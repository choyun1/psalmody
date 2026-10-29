// Makes the PNGs here from icon.svg and banner.html (needs Playwright):  node docs/brand/make.mjs
import { createRequire } from "node:module";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
const { chromium } = createRequire(import.meta.url)("playwright");
const here = dirname(fileURLToPath(import.meta.url));
const b = await chromium.launch();
for (const scheme of ["light", "dark"]) {
  const p = await b.newPage({colorScheme: scheme, deviceScaleFactor: 2});
  for (const [file, w, h] of [["banner", 1280, 320], ["social", 1280, 640]]) {
    await p.setViewportSize({width: w, height: h});
    await p.goto("file://" + join(here, "banner.html") + "?" + file); await p.waitForTimeout(400);
    await p.screenshot({path: join(here, `${file}-${scheme}.png`), omitBackground: false});
  }
  await p.setViewportSize({width: 256, height: 256});
  await p.goto("file://" + join(here, "banner.html") + "?icon"); await p.waitForTimeout(400);
  await p.screenshot({path: join(here, `icon-${scheme}.png`), omitBackground: true});
}
await b.close();
console.log("made the banner, social preview and icon PNGs in", here);
