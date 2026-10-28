// ---------- chant card ----------
function stars(r) { return r == null ? "" : `<span class="stars" title="your rating">${"★".repeat(r)}${"☆".repeat(Math.max(0, 5 - r))}</span>`; }
function chantCard(c, opts = {}) {
  const mood = val(c, "mood"), uses = usedBy[c.id] || [];
  const last = uses.length ? uses.slice().sort((a, b) => a.date < b.date ? 1 : -1)[0] : null;
  const usedTxt = uses.length ? `Used ${uses.length}× · last ${last.date} (${esc(textTitle[last.text] || last.text)}${last.verses ? " " + last.verses : ""})` : "Not used yet";
  const editing = opts.editing;
  return `<div class="card" id="card-${esc(c.id)}">
    <button class="small play" onclick="play('${esc(c.id)}', this)">▶ Play</button>${pinButtons(c)}
    <h2>${esc(CN(c.id))}</h2><span class="who">${esc(c.id)} · ${esc(c.composer)}${c.years ? " (" + esc(c.years) + ")" : ""}</span>
    <div class="facts"><b>${esc(keyName(c))}</b> · ${c.double ? "double" : "single"}
      ${c.range ? " · soprano " + esc(c.range.join("–")) : ""} ${c.acp ? " · ACP sets it to Ps " + esc(c.acp) : ""} ${stars(val(c, "rating"))}</div>
    <div class="moodrow">${mood.length ? mood.map(t => chip(t)).join("") : '<span class="hint">no mood tags yet</span>'}</div>
    ${c.img ? `<div class="notation"><img loading="lazy" src="${esc(chantImg(c))}" alt="${esc(c.id)}"></div>` : ""}
    ${notesBox(val(c, "notes"))}
    <div class="used">${usedTxt} ${uses.length > 1 ? `<span class="link" onclick="showUses('${esc(c.id)}')">all</span>` : ""}</div>
    ${editing ? editBox(c) : detailsOpen.has(c.id) ? detailsBox(c) : `<p style="margin:6px 0 0"><span class="link" onclick="openEdit('${esc(c.id)}')">Edit mood, rating, notes</span>
      ${SERVER ? `· <span class="link" onclick="openDetails('${esc(c.id)}')">Edit details</span> · <span class="link" onclick="editMusic('${esc(c.id)}')">Edit music</span>` : ""}
      · <span class="link" onclick="dlg.close(); useInBuilder('${esc(c.id)}')">Use in the Service planner</span></p>`}
  </div>`;
}
function editBox(c) {
  const mood = val(c, "mood"), r = val(c, "rating");
  return `<div class="edit">
    ${D.vocabulary.map(g => `<div class="moodpick">${g.tags.map(t => `<button class="chip g-${esc(g.group)} ${mood.includes(t) ? "on" : ""}" onclick="toggleMood('${esc(c.id)}','${esc(t)}')">${esc(t)}</button>`).join("")}</div>`).join("")}
    Rating: <select onchange="setEdit('${esc(c.id)}','rating', this.value === '' ? null : +this.value); refreshCard('${esc(c.id)}')">
      <option value="">–</option>${[1, 2, 3, 4, 5].map(n => `<option ${r === n ? "selected" : ""}>${n}</option>`).join("")}</select>
    <textarea placeholder="Notes on its character" onchange="setEdit('${esc(c.id)}','notes', this.value)">${esc(val(c, "notes"))}</textarea>
    <span class="link" onclick="closeEdit('${esc(c.id)}')">Done</span>
  </div>`;
}
const openEdits = new Set();
const OPEN = new Set();               // chants opened in the Chants list
function toggleRow(id) { OPEN.has(id) ? OPEN.delete(id) : OPEN.add(id); renderChants(); }
function openEdit(id) { openEdits.add(id); refreshCard(id); }
function closeEdit(id) { openEdits.delete(id); refreshCard(id); }
function toggleMood(id, t) {
  const m = val(C[id], "mood").slice(), i = m.indexOf(t);
  if (i >= 0) m.splice(i, 1); else m.push(t);
  setEdit(id, "mood", m); refreshCard(id);
}
function refreshCard(id) {
  document.querySelectorAll("#card-" + CSS.escape(id)).forEach(el => {
    el.outerHTML = chantCard(C[id], {editing: openEdits.has(id)});
  });
}
function showUses(id) {
  const rows = (usedBy[id] || []).slice().sort((a, b) => a.date < b.date ? 1 : -1);
  $("#dlgbody").innerHTML = `<h2 style="font-weight:normal">${esc(id)}: every use</h2><table class="hist">${rows.map(h =>
    `<tr><td>${esc(h.date)}</td><td>${esc(textTitle[h.text] || h.text)} ${esc(h.verses)}</td><td class="hint">${esc(h.note)}</td></tr>`).join("")}</table>`;
  dlg.showModal();
}
function showChant(id) { $("#dlgbody").innerHTML = chantCard(C[id], {editing: openEdits.has(id)}); dlg.showModal(); }

// ---------- keys ----------
const PC = {C: 0, "C#": 1, Db: 1, D: 2, "D#": 3, Eb: 3, E: 4, Fb: 4, F: 5, "E#": 5, "F#": 6, Gb: 6, G: 7, "G#": 8, Ab: 8, A: 9, "A#": 10, Bb: 10, B: 11, Cb: 11};
const pretty = k => k.replace("#", "♯").replace(/([A-G])b/, "$1♭");
function tonic(c) { return (c.key || "").split("/")[0].trim(); }
const MODES = {mix: "mixolydian", dor: "dorian", phr: "phrygian", lyd: "lydian", aeo: "aeolian"};
// transposing: a chant moved up or down so many semitones, and how chants are named on screen
const PCS = {C: 0, D: 2, E: 4, F: 5, G: 7, A: 9, B: 11};
const SPELLD = {major: ["C", "D♭", "D", "E♭", "E", "F", "F♯", "G", "A♭", "A", "B♭", "B"],
                minor: ["C", "C♯", "D", "E♭", "E", "F", "F♯", "G", "G♯", "A", "B♭", "B"]};
function keyAt(c, shift) {
  if (!shift) return keyName(c);
  const m0 = (c.mode || "").toLowerCase();
  const moveOne = (k, minor) => {               // 'Bb' up 2 -> 'C'
    const m = k.trim().match(/^([A-G])([#b♯♭]?)$/); if (!m) return null;
    const pc = (PCS[m[1]] + (/[#♯]/.test(m[2]) ? 1 : /[b♭]/.test(m[2]) ? -1 : 0) + shift + 120) % 12;
    return SPELLD[minor ? "minor" : "major"][pc];
  };
  const parts = (c.key || "").split("/");
  if (parts.length === 2 && m0 === "m/m") {     // a chant in two keys: major / minor
    const a = moveOne(parts[0], false), b = moveOne(parts[1], true);
    if (a && b) return `${a} major / ${b} minor`;
  }
  const minorish = ["min", "dor", "phr", "aeo"].includes(m0.slice(0, 3));
  const t = moveOne(parts[0], minorish);
  if (!t) return keyName(c);
  return t + " " + (m0.startsWith("min") ? "minor" : m0.startsWith("maj") || !m0 ? "major" : MODES[m0.slice(0, 3)] || m0);
}
function shiftWords(s) { return s ? `${s > 0 ? "up" : "down"} ${Math.abs(s)}` : ""; }
function CN(id) { return (C[id] && C[id].label) || id; }
// your notes, with the chants they mention by file name (Turle-2, or an old name such as Turle-5) named as on screen
let NOTE_REFS = null;
function notesHTML(text, links = true) {
  if (!NOTE_REFS) {
    const names = Object.keys(C).concat(Object.keys(D.aliases || {})).filter(n => /\d$/.test(n))   // Turle-2, not a bare surname
      .sort((a, b) => b.length - a.length);
    const escRe = n => n.replace(/[.*+?^$()|[\]\\{}]/g, "\\$&");
    NOTE_REFS = names.length ? new RegExp("(?<![\\w-])(" + names.map(escRe).join("|") + ")(?![\\w-])", "g") : null;
  }
  const html = esc(text);
  return NOTE_REFS ? html.replace(NOTE_REFS, m => {
    const r = chantRef(m), label = CN(r.name) + (r.shift ? ` (in ${keyAt(C[r.name], r.shift)})` : "");
    return links && C[r.name] ? `<span class="link" title="${esc(m)}" onclick="showChant('${esc(r.name)}')">${esc(label)}</span>` : `<span title="${esc(m)}">${esc(label)}</span>`;
  }) : html;
}
const notesBox = (text, links = true) => text ? `<div class="notes"><span class="nlabel">Notes</span>${notesHTML(text, links)}</div>` : "";
function chantRef(text) {           // 'Turle-2 down 2' -> {name: 'Turle-2', shift: -2}; an old name is the chant it copied
  const t = String(text || "").trim(), m = t.match(/^(.*?)\s+(up|down)\s+(\d+)$/i);
  let name = m ? m[1].trim() : t, shift = m ? +m[3] * (m[2].toLowerCase() === "up" ? 1 : -1) : 0;
  const a = (D.aliases || {})[name];
  if (a) { name = a[0]; shift += a[1]; }
  return {name, shift};
}
function chantText(text) { const r = chantRef(text); return C[r.name] ? CN(r.name) + (r.shift ? ` (in ${keyAt(C[r.name], r.shift)})` : "") : text; }
function keyName(c) {
  const k = c.key || "", m = (c.mode || "").toLowerCase();
  if (k.includes("/") && m === "m/m") { const [a, b] = k.split("/"); return `${pretty(a.trim())} major / ${pretty(b.trim())} minor`; }
  return pretty(tonic(c)) + " " + (MODES[m.slice(0, 3)] || m);
}
function keyRank(c, fifths) {
  const p = PC[tonic(c)] ?? 99;
  const minor = /^min/i.test(c.mode || ""), modal = !/^(maj|min)/i.test(c.mode || "");
  // circle of fifths: C G D A E B F♯ D♭ A♭ E♭ B♭ F; minor keys sit with their relative major
  const pos = fifths ? (((minor ? (p + 3) % 12 : p) * 7) % 12) : p;
  return pos * 10 + (minor ? 1 : modal ? 2 : 0);
}
const KEYS_PRESENT = [...new Set(D.chants.slice().sort((a, b) => keyRank(a, false) - keyRank(b, false)).map(keyName))];

// ---------- sorting: several levels, "sort by …, then by …", each ascending or descending ----------
const born = c => { const m = String(c.years || "").match(/\d{3,4}/); return m ? +m[0] : null; };
const NOTE_PC = {C: 0, D: 2, E: 4, F: 5, G: 7, A: 9, B: 11};
function topNote(c) {                                   // the soprano's highest note, as a MIDI number
  const n = String([].concat(c.range || []).slice(-1)[0] || "").split(/[–-]/).pop().trim().match(/^([A-G])([#♯b♭]?)(-?\d)$/);
  return n ? 12 * (+n[3] + 1) + NOTE_PC[n[1]] + (/[#♯]/.test(n[2]) ? 1 : /[b♭]/.test(n[2]) ? -1 : 0) : null;
}
// pins: ★ a favorite, 📌 one to try, ⚑ one to check (a doubt about a note); kept with the ratings in chant_notes.csv
const PINS = [["favorite", "★", "☆", "favorite"], ["to try", "📌", "📌", "to try"], ["to check", "⚑", "⚑", "to check"]];
const pinMarks = c => PINS.filter(([p]) => pinned(c, p)).map(([, on]) => on).join(" ");
const pinned = (c, p) => (val(c, "pins") || []).includes(p);
function togglePin(id, p) {
  const cur = val(C[id], "pins") || [];
  setEdit(id, "pins", cur.includes(p) ? cur.filter(x => x !== p) : PINS.map(x => x[0]).filter(x => x === p || cur.includes(x)));
  document.querySelectorAll(`[data-pins="${CSS.escape(id)}"]`).forEach(el => el.outerHTML = pinButtons(C[id]));
  if (!$("#tab-chants").hidden && !CV.tones) renderChants();          // the ★ / 📌 in its row
}
function pinButtons(c) {
  return `<span data-pins="${esc(c.id)}" style="float:right;margin-right:6px">${PINS.map(([p, on, off, label]) =>
    `<button class="small pin ${pinned(c, p) ? "on" : ""}" title="${pinned(c, p) ? "remove from " : "mark as "}${label}" onclick="togglePin('${esc(c.id)}','${p}')">${pinned(c, p) ? on : off}${pinned(c, p) ? " " + label : ""}</button>`).join(" ")}</span>`;
}
const pinFilter = (c, want) => !want || pinned(c, want);
const ordinal = n => n + (n % 100 >= 11 && n % 100 <= 13 ? "th" : ["th", "st", "nd", "rd"][n % 10] || "th");
const modeRank = c => /^maj/i.test(c.mode || "") ? 0 : /^min/i.test(c.mode || "") ? 1 : 2;
// each field: its label, its usual direction (1 ascending, -1 descending), the value to sort on, and,
// for some, a heading to group by when it's the first level. x is the picker's match (its score).
const SORT_FIELDS = {
  match:    {label: "best match", dir: -1, val: (c, x) => x ? x.s : 0, picker: true},
  composer: {label: "composer", dir: 1, val: c => (c.composer || c.id).toLowerCase()},
  born:     {label: "composer's birth year", dir: 1, val: born, head: c => born(c) ? `Born in the ${ordinal(Math.floor((born(c) - 1) / 100) + 1)} century` : "Birth year unknown"},
  mode:     {label: "major / minor", dir: 1, val: modeRank, head: c => ["Major", "Minor", "Modal and other"][modeRank(c)]},
  key:      {label: "key (C, D♭, D …)", dir: 1, val: c => keyRank(c, false), head: c => keyName(c)},
  fifths:   {label: "key (circle of fifths)", dir: 1, val: c => keyRank(c, true), head: c => keyName(c)},
  sd:       {label: "single / double", dir: 1, val: c => c.double ? 1 : 0, head: c => c.double ? "Double chants" : "Single chants"},
  rating:   {label: "rating", dir: -1, val: c => val(c, "rating") || null},
  pinned:   {label: "pinned first (★, 📌, then ⚑)", dir: 1, val: c => pinned(c, "favorite") ? 0 : pinned(c, "to try") ? 1 : pinned(c, "to check") ? 2 : null,
             head: c => pinned(c, "favorite") ? "★ Favorites" : pinned(c, "to try") ? "📌 To try" : pinned(c, "to check") ? "⚑ To check" : "The rest"},
  stale:    {label: "last used", dir: 1, val: c => lastUsed(c.id)},
  used:     {label: "times used", dir: -1, val: c => (usedBy[c.id] || []).length},
  range:    {label: "highest soprano note", dir: 1, val: topNote},
};
function sortLevels(name, fallback) {
  try { const v = JSON.parse(localStorage.getItem("psalter-sort-" + name)); if (Array.isArray(v) && v.length && v.every(l => SORT_FIELDS[l.f])) return v; } catch (e) {}
  return fallback;
}
function sortCompare(levels, chantOf) {
  return (a, b) => {
    for (const l of levels) {
      const f = SORT_FIELDS[l.f], va = f.val(chantOf(a), a), vb = f.val(chantOf(b), b);
      if (va === vb) continue;
      if (va == null || va === "") return 1;           // unknown last, whichever way
      if (vb == null || vb === "") return -1;
      return (va < vb ? -1 : 1) * l.d;
    }
    return chantOf(a).id.localeCompare(chantOf(b).id, undefined, {numeric: true});
  };
}
// the control: one row per level; view is "chants" or "picker"
const SORTS = {};
function sortControl(view, picker) {
  const levels = SORTS[view].levels;
  const opts = sel => Object.entries(SORT_FIELDS).filter(([k, f]) => picker || !f.picker)
    .map(([k, f]) => `<option value="${k}" ${k === sel ? "selected" : ""}>${esc(f.label)}</option>`).join("");
  return `<div class="sortlevels">${levels.map((l, i) => `<div class="row" style="gap:4px;margin-bottom:4px;flex-wrap:nowrap">
      <span class="hint" style="width:52px;flex:none">${i ? "then by" : "sort by"}</span>
      <select onchange="sortSet('${view}', ${i}, this.value)" style="min-width:0;flex:1">${opts(l.f)}</select>
      <button class="small" title="${l.d > 0 ? "ascending: click for descending" : "descending: click for ascending"}" onclick="sortDir('${view}', ${i})">${l.d > 0 ? "↑" : "↓"}</button>
      ${i ? `<span class="link" title="remove" onclick="sortDel('${view}', ${i})">✕</span>` : ""}</div>`).join("")}
    ${levels.length < 5 ? `<span class="link hint" onclick="sortAdd('${view}')">+ then by</span>` : ""}</div>`;
}
function sortChanged(view) {
  try { localStorage.setItem("psalter-sort-" + view, JSON.stringify(SORTS[view].levels)); } catch (e) {}
  SORTS[view].render();
}
function sortSet(view, i, f) { SORTS[view].levels[i] = {f, d: SORT_FIELDS[f].dir}; sortChanged(view); }
function sortDir(view, i) { SORTS[view].levels[i].d *= -1; sortChanged(view); }
function sortDel(view, i) { SORTS[view].levels.splice(i, 1); sortChanged(view); }
// a column heading in the Chants list, as in a spreadsheet: sort by it; again, the other way round. The sort
// levels underneath stay, after it.
function colSort(f) {
  const lv = SORTS.chants.levels;
  if (lv[0].f === f) lv[0].d *= -1;
  else SORTS.chants.levels = [{f, d: SORT_FIELDS[f].dir}].concat(lv.filter(l => l.f !== f)).slice(0, 5);
  sortChanged("chants");
}
function sortAdd(view) {
  const used = new Set(SORTS[view].levels.map(l => l.f));
  const f = ["mode", "key", "born", "composer", "rating"].find(k => !used.has(k)) || "composer";
  SORTS[view].levels.push({f, d: SORT_FIELDS[f].dir}); sortChanged(view);
}

// ---------- chants tab ----------
const F = {moods: new Set(), mode: "", sd: "", key: "", minRating: 0, q: "", untagged: false, pin: ""};
SORTS.chants = {levels: sortLevels("chants", [{f: "composer", d: 1}]), render: () => { $("#sortbox").innerHTML = sortControl("chants", false); renderChants(); }};
function renderChantsShell() {
  $("#tab-chants").innerHTML = `<div class="layout"><aside>
    <input type="search" id="q" placeholder="Composer or chant" style="width:100%">
    <h3>Mood</h3>${D.vocabulary.map(g => `<div class="row" style="margin-bottom:5px">${g.tags.map(t =>
      `<button class="chip g-${esc(g.group)}" data-mood="${esc(t)}">${esc(t)}</button>`).join("")}</div>`).join("")}
    <label class="hint"><input type="checkbox" id="untagged"> only chants without moods</label>
    <h3>Pinned</h3><select id="pinf"><option value="">all chants</option><option value="favorite">★ favorites</option><option value="to try">📌 to try</option><option value="to check">⚑ to check</option></select>
    <h3>Mode</h3><select id="mode"><option value="">any</option><option>Major</option><option>Minor</option><option value="other">modal / other</option></select>
    <h3>Key</h3><select id="keyf"><option value="">any</option>${KEYS_PRESENT.map(k => `<option>${esc(k)}</option>`).join("")}</select>
    <h3>Single or double</h3><select id="sd"><option value="">either</option><option value="s">single</option><option value="d">double</option></select>
    <h3>Rating at least</h3><select id="rating"><option value="0">any</option>${[1, 2, 3, 4, 5].map(n => `<option>${n}</option>`).join("")}</select>
    <h3>Sort</h3><div id="sortbox">${sortControl("chants", false)}</div>
  </aside><div>
    <div class="seg" style="max-width:440px;margin-bottom:10px"><button class="${CV.tones ? "" : "on"}" onclick="CV.tones=false; renderChantsShell(); renderChants()">Anglican chants</button><button class="${CV.tones ? "on" : ""}" onclick="CV.tones=true; renderChantsShell(); renderChants()">Plainchant psalm tones</button></div>
    ${SERVER && !CV.tones ? '<p style="margin:0 0 8px"><span class="link" onclick="newChant()">+ New chant</span></p>' : ""}
    <p class="count" id="ccount"></p><div id="clist"></div></div></div>`;
  if (CV.tones) { $("#tab-chants aside").style.display = "none"; $("#tab-chants .layout").style.gridTemplateColumns = "1fr"; }
  // the controls show the filters still in force (after the tones and back)
  $("#q").value = F.q; $("#untagged").checked = F.untagged; $("#pinf").value = F.pin || ""; $("#mode").value = F.mode || "";
  $("#sd").value = F.sd || ""; $("#keyf").value = F.key || ""; $("#rating").value = String(F.minRating || 0);
  document.querySelectorAll("[data-mood]").forEach(b => b.classList.toggle("on", F.moods.has(b.dataset.mood)));
  $("#q").oninput = e => { F.q = e.target.value.toLowerCase(); renderChants(); };
  document.querySelectorAll("[data-mood]").forEach(b => b.onclick = () => {
    const t = b.dataset.mood; F.moods.has(t) ? F.moods.delete(t) : F.moods.add(t); b.classList.toggle("on"); renderChants(); });
  $("#untagged").onchange = e => { F.untagged = e.target.checked; renderChants(); };
  $("#pinf").onchange = e => { F.pin = e.target.value; renderChants(); };
  $("#mode").onchange = e => { F.mode = e.target.value; renderChants(); };
  $("#sd").onchange = e => { F.sd = e.target.value; renderChants(); };
  $("#keyf").onchange = e => { F.key = e.target.value; renderChants(); };
  $("#rating").onchange = e => { F.minRating = +e.target.value; renderChants(); };
}
const CV = {tones: false, mode: 0};
function renderTones() {
  const groups = D.toneGroups || [], ends = {}; (D.tones || []).forEach(t => ends[t.name] = t);
  const shown = groups.filter(g => !CV.mode || (CV.mode === -1 ? g.mode === 0 : g.mode === CV.mode));
  const modes = [...new Set(groups.map(g => g.mode))];
  $("#ccount").innerHTML = `${groups.filter(g => g.mode).length} tones with ${(D.tones || []).length - 1} endings, and the tonus peregrinus, from the Liber usualis · mode: ` +
    [0].concat(modes.filter(m => m)).map(m => `<span class="link" style="${CV.mode === m ? "font-weight:bold" : ""}" onclick="CV.mode=${m}; renderChants()">${m ? ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII"][m] : "all"}</span>`).join(" · ") +
    (modes.includes(0) ? ` · <span class="link" style="${CV.mode === -1 ? "font-weight:bold" : ""}" onclick="CV.mode=-1; renderChants()">peregrinus</span>` : "");
  $("#clist").innerHTML = `<p class="hint" style="margin:0 0 10px">Each tone is printed as sung: the intonation (first verse only), the reciting note and the mediant cadence; then the reciting note and an ending. A tone's endings all share its first half, so pick whichever ending you like: the Liber chooses one to lead back into an antiphon, and without an antiphon the choice is yours. Notes in brackets are added or left out as the words need; ´ marks the notes that take an accented syllable. In the psalm builder, type <i>tone 1g2</i> in a chant box, or choose a tone and then its ending.</p>` +
    shown.map(g => `<div class="card">
      <h3 style="font-weight:normal;margin:0">${esc(g.label)}</h3>
      <div class="hint" style="margin:2px 0 6px">${esc(g.character)}${g.mode ? " · the spirit of the mode" : ""}</div>
      ${g.img ? `<div class="hint">First half (intonation, reciting note, mediant):</div><img src="notation/${encodeURIComponent(g.img)}" alt="${esc(g.label)}" style="max-width:100%;max-height:80px">` : ""}
      ${g.mode ? `<div class="hint" style="margin-top:6px">${g.endings.length > 1 ? g.endings.length + " endings" : "Its ending"}:</div>` : ""}
      <div class="endings">${g.endings.map(n => ends[n]).map(t => `<div class="ending">
        <div><b style="font-weight:normal">${t.ending && g.mode ? "Ending " + esc(t.ending) : esc(g.label)}</b> <span class="hint">· tone ${esc(t.name)}</span></div>
        ${t.img ? `<img src="notation/${encodeURIComponent(t.img)}" alt="${esc(t.label)}">` : ""}
        <div><button class="small play" onclick="playTone('${esc(t.name)}', this)">▶ Play</button>
          <span class="link" onclick="useInBuilder('tone ${esc(t.name)}')">Use</span>${toneUses(t)}</div></div>`).join("")}</div></div>`).join("");
}
function toneUses(t) {
  const want = t.name.toLowerCase().replace(/\W/g, "");
  const roman = t.label.replace(/^Tone /, "").toLowerCase().replace(/\W/g, "");
  const uses = D.history.filter(h => /^tone/i.test(h.chant || "") && [want, roman].includes(String(h.chant).replace(/^tone[:\s]*/i, "").toLowerCase().replace(/\W/g, "")));
  return uses.length ? ` <span class="hint">· used ${uses.length}×, last ${esc(uses.map(h => h.date).sort().pop())}</span>` : "";
}
function renderChants() {
  if (CV.tones) { renderTones(); return; }
  let list = D.chants.filter(c => {
    const mood = val(c, "mood"), r = val(c, "rating") || 0;
    if (F.q && !(c.id + " " + c.composer + " " + c.label).toLowerCase().includes(F.q)) return false;
    if (F.moods.size && ![...F.moods].some(t => mood.includes(t))) return false;
    if (F.untagged && mood.length) return false;
    if (!pinFilter(c, F.pin)) return false;
    if (F.mode === "other" ? ["Major", "Minor"].includes(c.mode) : F.mode && c.mode !== F.mode) return false;
    if (F.sd && (F.sd === "d") !== c.double) return false;
    if (F.key && keyName(c) !== F.key) return false;
    if (r < F.minRating) return false;
    return true;
  });
  const levels = SORTS.chants.levels;
  list.sort(sortCompare(levels, c => c));
  const tagged = D.chants.filter(c => val(c, "mood").length).length;
  $("#ccount").textContent = `${list.length} of ${D.chants.length} chants · ${tagged} have mood tags`;
  let prevKey = null;
  const heading = SORT_FIELDS[levels[0].f].head;
  const first = SORTS.chants.levels[0];
  const col = (f, label, cls = "") => `<span class="meta sortable ${cls} ${first.f === f ? "on" : ""}" title="Sort by ${esc(SORT_FIELDS[f].label)} (click again to reverse)" onclick="colSort('${f}')">${label}${first.f === f ? (first.d > 0 ? " ▲" : " ▼") : ""}</span>`;
  $("#clist").innerHTML = `<div class="clist"><div class="crow head">${col("composer", "Chant")}${col("key", "Key")}${col("rating", "Rating")}${col("stale", "Last sung")}<span class="meta mo">Moods</span></div>` + list.map(c => {
    let head = "";
    if (heading) {
      const k = heading(c);
      if (k !== prevKey) head = `<h3 class="grp">${esc(k)}</h3>`;
      prevKey = k;
    }
    const open = OPEN.has(c.id);
    return head + `<div class="crow ${open ? "open" : ""}" onclick="toggleRow('${esc(c.id)}')"><span class="nm">${pinMarks(c) ? pinMarks(c) + " " : ""}${esc(CN(c.id))}</span>
      <span class="meta">${esc(keyName(c))}${c.double ? "" : ", single"}</span><span>${stars(val(c, "rating"))}</span>
      <span class="meta">${esc(lastUsed(c.id) || "never")}</span><span class="mo">${val(c, "mood").map(t => chip(t)).join(" ")}</span></div>`
      + (open ? chantCard(c, {editing: openEdits.has(c.id)}) : "");
  }).join("") + `</div>`;
}

// ---------- matching ----------
function score(textTags, chantTags) {
  if (!textTags.length || !chantTags.length) return {s: 0, hits: []};
  let s = 0; const hits = [];
  textTags.forEach((t, i) => {
    const w = i === 0 ? 1.0 : 0.75;            // the first tag is the main character
    if (chantTags.includes(t)) { s += w; hits.push(t); }
    else if (chantTags.some(c => GROUP[c] && GROUP[c] === GROUP[t])) s += 0.4 * w;
  });
  return {s: s / textTags.length, hits};
}
function suggestions(sec) {
  return D.chants.map(c => ({c, ...score(sec.mood, val(c, "mood"))}))
    .filter(x => x.s > 0)
    .sort((a, b) => b.s - a.s || (val(b.c, "rating") || 0) - (val(a.c, "rating") || 0) || lastUsed(a.c.id).localeCompare(lastUsed(b.c.id)))
    .slice(0, 10);
}
