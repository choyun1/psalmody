// ---------- the launcher: saving, Undo and Changes, Sync with GitHub ----------
let SERVER = false;
if (location.protocol.startsWith("http")) fetch("/api/ping").then(r => r.ok && r.json()).then(j => { if (j && j.ok) { SERVER = true; renderSavebar(); renderHistory(); refreshGit(); if (!$("#tab-builder").hidden) renderBuilder(); } }).catch(() => {});
let CHANGES = [], PENDING = {n: 0, files: []};
// a cloud with two arrows going round: syncing with an online copy
const SYNC_ICON = `<svg class="icon" viewBox="0 0 24 24" aria-hidden="true"><path d="M7 18h10a4 4 0 0 0 .6-7.95A6 6 0 0 0 6.1 9.2 4.5 4.5 0 0 0 7 18z" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/><path d="M9.5 12.5a2.6 2.6 0 0 1 4.6-1.2M14.5 13.5a2.6 2.6 0 0 1-4.6 1.2" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round"/><path d="M14.6 9.6v1.9h-1.9M9.4 16.4v-1.9h1.9" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/></svg>`;
async function refreshGit() {
  if (!SERVER) return;
  try {
    const [g, h] = await Promise.all([fetch("/api/git").then(r => r.json()), fetch("/api/history").then(r => r.json())]);
    CHANGES = h.changes || [];
    const n = g.repos.reduce((a, r) => a + r.unpushed + r.files.length, 0);
    const last = CHANGES[0];
    $("#gitbar").innerHTML = (last ? ` <button class="small" title="Undo: ${esc(last.message)}" onclick="undoChange(0)">↶ Undo</button>
      <button class="small" onclick="showChanges()">Changes</button>` : "")
      + ` <button class="small sync" title="Back up to GitHub, and bring in what's new there (click for more)" onclick="showSync()">${SYNC_ICON} Sync with GitHub${n ? ` <span class="badge">${n}</span>` : ""}</button>`;
    PENDING = {n, files: g.repos.flatMap(r => r.files.map(f => r.repo + ": " + f))};
    if (dlg.open && $("#changes")) showChanges();
  } catch (e) {}
}
function whenText(t) {
  const d = new Date(t * 1000), now = new Date();
  const time = d.toLocaleTimeString([], {hour: "numeric", minute: "2-digit"});
  if (d.toDateString() === now.toDateString()) return "today " + time;
  const y = new Date(now); y.setDate(now.getDate() - 1);
  if (d.toDateString() === y.toDateString()) return "yesterday " + time;
  return d.toLocaleDateString([], {month: "short", day: "numeric", year: d.getFullYear() === now.getFullYear() ? undefined : "numeric"}) + " " + time;
}
function showChanges() {
  $("#dlgbody").innerHTML = `<h3>Changes</h3>
    <p class="muted">Every save here is kept, newest first. Undo puts back what a change changed, as a new change, so an undo can itself be undone. Sync with GitHub brings in what's new there and sends a copy of these.</p>
    <table id="changes">${CHANGES.map((c, i) => `<tr><td class="muted" style="white-space:nowrap">${whenText(c.time)}</td>
      <td>${esc(c.message)}${c.pushed ? "" : ' <span class="muted" title="Recorded on this computer, not yet saved to GitHub">•</span>'}</td>
      <td><button class="small" onclick="undoChange(${i})">Undo</button></td></tr>`).join("") || '<tr><td class="muted">Nothing yet.</td></tr>'}</table>`;
  if (!dlg.open) dlg.showModal();
}
async function undoChange(i) {
  const c = CHANGES[i];
  if (!c || !window.confirm(`Undo this change?\n\n${c.message} (${whenText(c.time)})`)) return;
  $("#gitbar").textContent = " Undoing…";
  const j = await post("/api/undo", {repo: c.repo, sha: c.sha});
  if (!j.ok) { window.alert("Could not undo: " + (j.error || "something went wrong")); return refreshGit(); }
  location.reload();                    // the page was rebuilt without that change
}
// why and what: a dialog before syncing, and the outcome in it after
function showSync(result) {
  const waiting = CHANGES.filter(c => !c.pushed);
  $("#dlgbody").innerHTML = `<h3>${SYNC_ICON} Sync with GitHub</h3>
    <p>Everything you save here is kept on this computer at once, and Undo works without GitHub. Syncing does three more things:</p>
    <ul>
      <li><b>A backup.</b> Your Sunday files, chant notes, pointing and anthem words go to your own GitHub account, safe if this computer is lost or replaced.</li>
      <li><b>Your other computers.</b> What you saved on another computer comes here, and what you saved here goes there. Sync before you start on another computer, and when you finish.</li>
      <li><b>Updates.</b> Fixes and improvements to the tools come in (then restart the launcher).</li>
    </ul>
    ${result ? `<div class="card" style="margin:10px 0">${esc(result).replace(/\n/g, "<br>")}</div>` :
      PENDING.n ? `<p class="hint">Not on GitHub yet (${PENDING.n}):</p><ul class="hint" style="margin-top:0">${waiting.slice(0, 8).map(c => `<li>${esc(c.message)} <span class="muted">· ${whenText(c.time)}</span></li>`).join("")}${PENDING.files.length ? `<li>files changed outside the browser: ${esc(PENDING.files.slice(0, 5).join(", "))}${PENDING.files.length > 5 ? "…" : ""}</li>` : ""}${waiting.length > 8 ? `<li>and ${waiting.length - 8} more</li>` : ""}</ul>`
      : '<p class="hint">Nothing waiting to go up; syncing still brings in anything new.</p>'}
    ${result ? "" : `<p><button class="small primary" onclick="commitAll()">${SYNC_ICON} Sync now</button></p>`}`;
  if (!dlg.open) dlg.showModal();
}
async function commitAll() {
  $("#dlgbody").querySelector("button.primary")?.replaceWith(Object.assign(document.createElement("span"), {className: "hint", textContent: "Syncing with GitHub…"}));
  let j;
  try { j = await post("/api/commit", {}); } catch (e) { j = {ok: false, error: "the launcher didn't answer: is it still running?"}; }
  if (j.ok && /brought in/.test(j.log || "")) { location.reload(); return; }     // new things came: show them
  showSync(j.ok ? (j.log || "Done.") : "Could not sync: " + (j.error || j.log || "something went wrong"));
  refreshGit();
}
setInterval(refreshGit, 30000);
async function post(url, obj) {
  const r = await fetch(url, {method: "POST", headers: {"Content-Type": "application/json"}, body: JSON.stringify(obj)});
  setTimeout(refreshGit, 800);
  return r.json();
}
