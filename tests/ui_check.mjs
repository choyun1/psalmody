// A walk through the chant browser in a real (headless) browser, looking for anything that breaks:
//
//     python tools/browser.py && node tests/ui_check.mjs        (needs: npm install playwright; npx playwright install chromium)
//
// It starts the launcher on a spare port (in a throwaway copy of nothing: it only reads, plus one Sunday file it
// removes), opens every tab, and tries the main things on each. Any error in the page fails the check.
import { createRequire } from "node:module";
import { spawn } from "node:child_process";
import { mkdtempSync, rmSync, existsSync } from "node:fs";
import { tmpdir } from "node:os";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";
const { chromium } = createRequire(import.meta.url)("playwright");     // installed here (npm) or globally

const ROOT = join(dirname(fileURLToPath(import.meta.url)), "..");
const PORT = 8700 + Math.floor(Math.random() * 90);
const home = mkdtempSync(join(tmpdir(), "psalter-ui-"));
const py = process.env.PYTHON || "python";
const server = spawn(py, ["tools/serve.py"], {cwd: ROOT, env: {...process.env, PSALTER_PORT: String(PORT), BROWSER: "true", HOME: home}});
let serverLog = ""; server.stdout.on("data", d => serverLog += d); server.stderr.on("data", d => serverLog += d);

const errors = [], steps = [];
const step = async (name, fn) => { try { await fn(); steps.push("ok   " + name); } catch (e) { errors.push(`${name}: ${e.message.split("\n")[0]}`); steps.push("FAIL " + name); } };
const wait = ms => new Promise(r => setTimeout(r, ms));

async function up() {
  for (let i = 0; i < 60; i++) { try { if ((await fetch(`http://localhost:${PORT}/api/ping`)).ok) return; } catch (e) {} await wait(1000); }
  throw new Error("the launcher did not start:\n" + serverLog);
}

const browser = await chromium.launch();
try {
  await up();
  const page = await browser.newPage({viewport: {width: 1280, height: 900}});
  page.on("pageerror", e => errors.push("page error: " + e.message));
  page.on("console", m => { if (m.type() === "error" && !/favicon/.test(m.text())) errors.push("console: " + m.text()); });
  page.on("dialog", d => d.dismiss());
  await page.goto(`http://localhost:${PORT}/`); await wait(1500);

  await step("Coming up: open a day", async () => {
    await page.click(".urow >> nth=0"); await wait(200);
    if (!await page.locator("#tab-upcoming .card").count()) throw new Error("the day did not open");
  });
  await step("Chants: sort by a column, open a chant, filter", async () => {
    await page.click("nav button[data-tab=chants]"); await wait(300);
    await page.click(".crow.head .sortable >> nth=1"); await wait(100);
    await page.click("#clist .crow:not(.head) >> nth=0"); await wait(200);
    if (!await page.locator("#clist .card").count()) throw new Error("the chant did not open");
    await page.fill("#q", "goss"); await wait(200);
    await page.fill("#q", "");
  });
  await step("Chants: the music editor opens and draws", async () => {
    await page.click("#clist .card .link:has-text('Edit music')"); await wait(6000);
    if (!await page.locator("#me-pic img").count()) throw new Error("no picture");
    await page.evaluate(() => dlg.close());
  });
  await step("Psalms: a psalm and its text", async () => {
    await page.click("nav button[data-tab=texts]"); await wait(300);
    await page.evaluate(() => goText("Psalm_023")); await wait(300);
  });
  await step("History: the record", async () => { await page.click("nav button[data-tab=history]"); await wait(300); });
  await step("Planner: a Sunday, a chant, transposed, the text, the preview", async () => {
    await page.click("nav button[data-tab=builder]"); await wait(500);
    await page.evaluate(() => setDate("2026-11-15")); await wait(800);
    await page.evaluate(() => { B.psalms[0].chants[0] = {name: "Turle-2", from: "", shift: -2}; B.psalms[0].open = true; B.previewOpen = true; renderBuilder(); });
    await wait(5000);
    const text = await page.evaluate(() => sundayText());
    if (!/chant:\s+Turle-2 down 2/.test(text)) throw new Error("the Sunday file lacks the chant:\n" + text);
  });
  await step("Planner: a verse pointed for this service", async () => {
    await page.hover("#tab-builder .ptext .v >> nth=0"); await page.click("#tab-builder .ptext .pen >> nth=0"); await wait(300);
    const ta = page.locator("#eta"); await ta.fill((await ta.inputValue()).replace(/ \| /, "  "));
    await page.click("button:has-text('Use for this service')"); await wait(1500);
  });
  await step("Planner: save and check (one at a time)", async () => {
    await page.fill("#bname", "zz-ui-check"); await page.press("#bname", "Tab"); await wait(200);
    await page.evaluate(() => { checkSunday(); checkSunday(); }); await wait(4000);
    const st = await page.evaluate(() => B.status);
    if (!/Checks done|Problem/.test(st)) throw new Error("status: " + st);
  });
  await step("Sync: the confirmation opens and cancels", async () => {
    await page.click("button.sync"); await wait(200);
    await page.click("#syncpop button:has-text('Cancel')");
  });
  await step("Phone width: the Chants list is usable", async () => {
    await page.setViewportSize({width: 390, height: 800});
    await page.click("nav button[data-tab=chants]"); await wait(300);
    await page.click("#clist .crow:not(.head) >> nth=2", {timeout: 3000});
    const w = await page.evaluate(() => document.documentElement.scrollWidth);
    if (w > 400) throw new Error("the page scrolls sideways: " + w + "px");
  });
} finally {
  await browser.close();
  server.kill();
  rmSync(home, {recursive: true, force: true});
  for (const f of ["sundays/zz-ui-check.txt", "parish/sundays/zz-ui-check.txt"]) if (existsSync(join(ROOT, f))) rmSync(join(ROOT, f));
}
console.log(steps.join("\n"));
if (errors.length) { console.error("\n" + errors.join("\n")); process.exit(1); }
console.log("\nThe chant browser works.");
