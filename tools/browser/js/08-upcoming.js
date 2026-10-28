// ---------- coming up ----------
const TX = {}; D.texts.forEach(t => TX[t.id] = t);
function overlapMoods(textIds, verses) {
  const out = [];
  textIds.forEach(id => (TX[id] ? TX[id].sections : []).forEach(s => {
    if (s.verses !== "all" && verses) {
      const [lo, hi] = s.verses.split("-").map(Number);
      if (!verses.some(v => v >= lo && v <= (hi || lo))) return;
    }
    s.mood.forEach(m => { if (!out.includes(m)) out.push(m); });
  }));
  return out;
}
function recentChants(date, weeks = 12) {
  if (!date) date = new Date().toISOString().slice(0, 10);
  const lo = new Date(new Date(date) - weeks * 7 * 864e5).toISOString().slice(0, 10);
  const set = new Set(D.history.filter(h => h.date >= lo && h.date < date).map(h => h.chant));
  D.calendar.filter(c => c.date >= lo && c.date < date).forEach(c => c.planned.forEach(pl => pl.chants.forEach(x => set.add(x))));
  return set;
}
function goText(id) {
  curText = id;
  document.querySelector('nav button[data-tab="texts"]').click();
}
function renderUpcoming() {
  const today = new Date().toISOString().slice(0, 10);
  const all = D.calendar.filter(c => c.date >= today), rows = all.slice(0, UPCOMING.n);
  const first = c => c.options.find(o => o.track === "Track " + D.parish.track) || c.options[0];
  $("#tab-upcoming").innerHTML = `<p class="count">The psalms appointed for the coming weeks${info("The Revised Common Lectionary (Episcopal edition). In the season after Pentecost, Track 1 is the semicontinuous psalm and Track 2 the one related to the Old Testament reading. Click a day for its psalms, their moods and chants to try.")}</p>
    <div class="clist">` + rows.map(c => {
    const open = UPCOMING.open.has(c.date), f = first(c);
    const status = c.planned.map(pl => `<span class="chip ${pl.sung ? "g-calm on" : "g-calm"}">${pl.sung ? "sung" : "planned"}: ${pl.choir === false ? "no choir" : esc(pl.chants.map(chantText).join(", ") || "chant not chosen")}</span>`).join(" ");
    const row = `<div class="crow urow ${open ? "open" : ""}" onclick="UPCOMING.open.has('${c.date}') ? UPCOMING.open.delete('${c.date}') : UPCOMING.open.add('${c.date}'); renderUpcoming()">
      <span class="nm">${swatch(c.date)}${esc(new Date(c.date + "T12:00").toLocaleDateString(undefined, {weekday: "short", month: "short", day: "numeric"}))}</span>
      <span>${esc(c.label)} <span class="meta">· ${esc(c.year)}</span></span>
      <span class="meta">${f ? (/^\d/.test(f.spec) ? "Ps " : "") + esc(f.spec) + (c.options.length > 1 ? ` <span title="${esc(c.options.slice(1).map(o => o.spec).join(", "))}">+${c.options.length - 1}</span>` : "") : "—"}</span>
      <span>${status}</span></div>`;
    if (!open) return row;
    const recent = recentChants(c.date);
    return row + `<div class="card"><p style="margin:0 0 4px">${lectLink("The readings for " + c.label, c.link)} · <span class="link" onclick="planOn('${c.date}')">Plan this day</span></p>
      ${c.options.length ? c.options.map(o => {
        const mood = overlapMoods(o.texts, o.verses);
        const sg = mood.length ? D.chants.map(ch => ({ch, ...score(mood, val(ch, "mood"))})).filter(x => x.s > 0 && !recent.has(x.ch.id))
          .sort((a, b) => b.s - a.s || (val(b.ch, "rating") || 0) - (val(a.ch, "rating") || 0)).slice(0, 4) : [];
        return `<div class="section"><div class="moodrow"><b style="font-weight:normal">${o.track ? esc(o.track) + ": " : ""}${/^\d/.test(o.spec) ? "Psalm " : ""}${esc(o.spec)}</b>
          ${o.texts.map(id => `<span class="link" onclick="goText('${esc(id)}')">${esc(TX[id] ? TX[id].title : id)}</span>`).join(", ")}
          ${mood.map(m => chip(m)).join(" ")}${o.error ? ` <span class="hint">${/^\d/.test(o.spec) ? esc(o.error) : "not in the library yet"}</span>` : ""}</div>
          ${sg.length ? `<div class="used">Try: ${sg.map(x => `<span class="link" onclick="showChant('${esc(x.ch.id)}')">${esc(CN(x.ch.id))}</span>`).join(" · ")}</div>` : ""}</div>`;
      }).join("") : '<p class="hint">No psalm in the table for this day.</p>'}</div>`;
  }).join("") + `</div>` + (all.length > rows.length ? `<span class="link more" onclick="UPCOMING.n += 12; renderUpcoming()">Show more weeks</span>` : "");
}
async function planOn(date) { B.started = true; await setDate(date); document.querySelector('nav button[data-tab="builder"]').click(); }
const UPCOMING = {n: 8, open: new Set()};
