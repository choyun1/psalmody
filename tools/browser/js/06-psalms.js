// ---------- pointing editor ----------
const E = {on: false, n: null, lines: [], msg: "", busy: false};
function verseBlock(v) {
  const [n, dag, lines] = v;
  const num = (dag ? "†" : "") + n;
  return lines.map((l, i) => {
    const t = (l[2] ? "+ " : "") + l[0];
    if (i === 0) return (num.length < 4 ? num.padEnd(4) : num + " ") + t;
    return (l[1] === 1 ? "    " : "      ") + t;
  }).join("\n");
}
function editableText(t) {
  return '<div class="ptext">' + t.body.map(v => v[0] === E.n ? verseEditor(t, v) :
    `<div class="v" style="cursor:pointer" title="Click to edit this verse" onclick="startEdit(${JSON.stringify(v[0])})">${pointedHTML([v]).replace(/^<div class="ptext">|<\/div>$/g, "")}</div>`).join("") +
    '</div><p class="hint">Click a verse to edit it. In the editor, click a word to put a bar before it (or take it away); Shift+click to mark it held; or type in the box. Saving checks that the words still match the 1979 BCP.</p>';
}
function startEdit(n) {
  const t = D.texts.find(x => x.id === curText);
  const v = t.body.find(x => x[0] === n);
  E.n = n; E.lines = verseBlock(v).split("\n"); E.msg = ""; renderText();
}
function editorPreview() {
  return E.lines.map((line, li) => {
    const m = line.match(/^(\s*(?:†?\d+\s+)?(?:\+ )?)(.*)$/);
    const toks = m[2].split(" ").filter(x => x !== "");
    return `<div>${esc(m[1].replace(/ /g, "\u00a0"))}${toks.map((tk, ti) =>
      tk === "|" ? '<span class="pbar"></span>' :
      tk === "." ? " · " :
      tk === "*" ? " * " :
      `<span class="tok" data-li="${li}" data-ti="${ti}" style="cursor:pointer;padding:0 2px;border-radius:3px" onmouseover="this.style.background='var(--line)'" onmouseout="this.style.background=''" onclick="clickTok(event, ${li}, ${ti})">${tk.startsWith("=") ? '<span class="held">' + esc(tk.slice(1)) + "</span>" : esc(tk)}</span> `).join("")}</div>`;
  }).join("");
}
function verseEditor(t, v) {
  const preview = editorPreview();
  return `<div class="v" style="background:var(--bg);border:1px solid var(--line);border-radius:8px;padding:8px 10px;margin:6px 0">
    <div id="eprev" style="font: 16px/1.7 EBG, Georgia, serif">${preview}</div>
    <textarea id="eta" spellcheck="false" oninput="E.lines=this.value.split('\\n'); $('#eprev').innerHTML=editorPreview()" style="width:100%;height:${E.lines.length * 1.6 + 1.2}em;font: 14px/1.6 ui-monospace, Menlo, Consolas, monospace;margin-top:6px">${esc(E.lines.join("\n"))}</textarea>
    <p style="margin:6px 0 0"><button class="small primary" ${E.busy ? "disabled" : ""} onclick="saveVerse()">Save verse</button>
      <button class="small" onclick="E.n=null; E.msg=''; renderText()">Cancel</button>
      ${E.msg ? `<span class="hint" style="margin-left:8px">${esc(E.msg)}</span>` : ""}</p>
    <p class="hint" style="margin:4px 0 0">| bar · . split · * mediant · =word held · word- | -word divided word · + line runs over · † before the number: second half again</p>
  </div>`;
}
function clickTok(ev, li, ti) {
  const ta = $("#eta"); if (ta) E.lines = ta.value.split("\n");
  const line = E.lines[li];
  const m = line.match(/^(\s*(?:†?\d+\s+)?(?:\+ )?)(.*)$/);
  const toks = m[2].split(" ").filter(x => x !== "");
  if (ev.shiftKey) {
    toks[ti] = toks[ti].startsWith("=") ? toks[ti].slice(1) : "=" + toks[ti];
  } else if (ti > 0 && toks[ti - 1] === "|") {
    toks.splice(ti - 1, 1);
  } else {
    toks.splice(ti, 0, "|");
  }
  E.lines[li] = m[1] + toks.join(" ");
  renderText();
}
async function saveVerse() {
  const ta = $("#eta"); if (ta) E.lines = ta.value.split("\n");
  E.busy = true; E.msg = "Saving…"; renderText();
  const j = await post("/api/text", {id: curText, n: E.n, block: E.lines.join("\n")});
  E.busy = false;
  if (!j.ok) { E.msg = j.error || "Could not save"; renderText(); return; }
  const t = D.texts.find(x => x.id === curText);
  const i = t.body.findIndex(x => x[0] === E.n);
  t.body[i] = j.verse;
  E.n = null; E.msg = ""; renderText();
}

// ---------- psalms tab ----------
let curText = null, textOpen = true;
function renderTextsShell() {
  $("#tab-texts").innerHTML = `<div class="layout"><aside>
    <input type="search" id="tq" placeholder="Number, title or words" style="width:100%">
    <h3>Mood</h3>${D.vocabulary.map(g => `<div class="row" style="margin-bottom:5px">${g.tags.map(t =>
      `<button class="chip g-${esc(g.group)}" data-tmood="${esc(t)}">${esc(t)}</button>`).join("")}</div>`).join("")}
    <h3>Psalms</h3><ul class="list" id="tlist"></ul></aside><div id="tdetail"></div></div>`;
  const tm = new Set();
  const draw = () => {
    const q = $("#tq").value.toLowerCase().trim();
    const items = D.texts.filter(t => {
      if (q && !(t.title.toLowerCase().includes(q) || t.latin.toLowerCase().includes(q) || t.first.toLowerCase().includes(q) || t.id.replace(/_0*/g, " ").toLowerCase().includes(q))) return false;
      if (tm.size && !t.sections.some(s => s.mood.some(m => tm.has(m)))) return false;
      return true;
    });
    $("#tlist").innerHTML = items.map(t => `<li data-id="${esc(t.id)}" class="${t.id === curText ? "on" : ""}"><span>${esc(t.title)}</span>
      <span class="dots">${[...new Set(t.sections.flatMap(s => s.mood.slice(0, 1)))].map(m => `<span class="dot ${gclass(m)}" title="${esc(m)}"></span>`).join("")}</span></li>`).join("");
    document.querySelectorAll("#tlist li").forEach(li => li.onclick = () => { curText = li.dataset.id; draw(); renderText(); });
  };
  $("#tq").oninput = draw;
  document.querySelectorAll("[data-tmood]").forEach(b => b.onclick = () => {
    const t = b.dataset.tmood; tm.has(t) ? tm.delete(t) : tm.add(t); b.classList.toggle("on"); draw(); });
  curText = curText || D.texts[0].id;
  draw(); renderText();
}
function renderText() {
  const t = D.texts.find(x => x.id === curText); if (!t) return;
  const hist = (textHist[t.id] || []).slice().sort((a, b) => a.date < b.date ? 1 : -1);
  const tagged = D.chants.filter(c => val(c, "mood").length).length;
  $("#tdetail").innerHTML = `<div class="card">
    <h2>${esc(t.title)}</h2><span class="latin">${esc(t.latin)}</span>
    <div class="facts">verses ${t.verses ? t.verses.join("–") : ""}${t.draft ? " · <b>not yet pointed</b>" : ""} · <span class="link" onclick="buildThisPsalm('${esc(t.id)}')">set this psalm to a chant</span></div>
    <details ${textOpen ? "open" : ""} ontoggle="textOpen=this.open"><summary>The text</summary>
      ${SERVER ? `<p style="margin:6px 0"><label class="hint"><input type="checkbox" ${E.on ? "checked" : ""} onchange="E.on=this.checked; E.n=null; renderText()"> edit the pointing</label></p>`
               : `<p class="hint" style="margin:6px 0">To edit the pointing, open the browser with the launcher.</p>`}
      ${E.on ? editableText(t) : pointedHTML(t.body)}</details>
    ${t.sections.map(s => {
      const sg = suggestions(s);
      return `<div class="section"><div class="moodrow"><b style="font-weight:normal">${s.verses === "all" ? "Whole text" : "Verses " + esc(s.verses)}</b>
        ${s.mood.map(m => chip(m)).join("")} <span class="hint">${esc(s.type)}${s.note ? " · " + esc(s.note) : ""}</span></div>
        ${sg.length ? `<table class="sugg"><tr><th>Chant</th><th>Key</th><th>Shares</th><th>Rating</th><th>Last used</th></tr>${sg.map(x =>
          `<tr><td><span class="link" onclick="showChant('${esc(x.c.id)}')">${esc(CN(x.c.id))}</span></td><td>${esc(keyName(x.c))}, ${x.c.double ? "double" : "single"}</td>
          <td>${x.hits.map(h => chip(h)).join(" ") || '<span class="hint">same family</span>'}</td><td>${stars(val(x.c, "rating"))}</td><td>${esc(lastUsed(x.c.id))}</td></tr>`).join("")}</table>`
          : `<p class="hint">No matching chants yet${tagged ? "" : ": none of the chants has mood tags so far. Tag them on the Chants tab"}.</p>`}
      </div>`;
    }).join("") || '<p class="hint">No mood tags for this text (texts/moods.csv).</p>'}
    <h3 style="font-weight:normal;margin-bottom:4px">${D.parish.name ? "Sung at " + esc(D.parish.name) : "Past use"}</h3>
    ${hist.length ? `<table class="hist">${hist.map(h => `<tr><td>${esc(h.date)}</td><td>${esc(h.verses)}</td><td>${C[h.chant] ? `<span class="link" onclick="showChant('${esc(h.chant)}')">${esc(CN(h.chant))}</span>${h.shift ? ` <span class="hint">${shiftWords(h.shift)}</span>` : ""}` : h.chant && h.chant !== "?" ? esc(h.chant.replace(/^tone:/, "Tone ")) : '<span class="hint">no chant</span>'}</td><td class="hint">${esc(h.note)}</td></tr>`).join("")}</table>` : '<p class="hint">Not yet.</p>'}
  </div>`;
}
