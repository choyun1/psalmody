// ---------- the launcher: saving, Undo and Changes, Sync with GitHub ----------
let SERVER = false;
if (location.protocol.startsWith("http")) fetch("/api/ping").then(r => r.ok && r.json()).then(j => { if (j && j.ok) { SERVER = true; renderSavebar(); renderHistory(); refreshGit(); if (!$("#tab-builder").hidden) renderBuilder(); } }).catch(() => {});
let CHANGES = [];
async function refreshGit() {
  if (!SERVER) return;
  try {
    const [g, h] = await Promise.all([fetch("/api/git").then(r => r.json()), fetch("/api/history").then(r => r.json())]);
    CHANGES = h.changes || [];
    const n = g.repos.reduce((a, r) => a + r.unpushed + r.files.length, 0);
    const last = CHANGES[0];
    $("#gitbar").innerHTML = (last ? ` <button class="small" title="Undo: ${esc(last.message)}" onclick="undoChange(0)">↶ Undo</button>
      <button class="small" onclick="showChanges()">Changes</button>` : "")
      + ` <button class="small" title="${esc((n ? "Not yet on GitHub:\n" + (g.repos.flatMap(r => r.files.map(f => r.repo + ": " + f)).join("\n") || n + " change(s) recorded here") + "\n\n" : "") + "Brings in what's new on GitHub, then sends what's new here")}" onclick="commitAll()">⇅ Sync with GitHub${n ? " (" + n + ")" : ""}</button>`;
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
async function commitAll() {
  $("#gitbar").textContent = " Syncing with GitHub…";
  const j = await post("/api/commit", {});
  window.alert(j.log || j.error || (j.ok ? "Saved." : "Something went wrong."));
  if (j.ok && /brought in/.test(j.log || "")) location.reload(); else refreshGit();
}
setInterval(refreshGit, 30000);
async function post(url, obj) {
  const r = await fetch(url, {method: "POST", headers: {"Content-Type": "application/json"}, body: JSON.stringify(obj)});
  setTimeout(refreshGit, 800);
  return r.json();
}
