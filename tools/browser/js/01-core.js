"use strict";
const D = window.PSALTER;
const $ = (s, el = document) => el.querySelector(s);
const esc = s => String(s ?? "").replace(/[&<>"]/g, c => ({"&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;"}[c]));

// ---------- vocabulary ----------
const GROUP = {}; const ORDER = [];
D.vocabulary.forEach(g => g.tags.forEach(t => { GROUP[t] = g.group; ORDER.push(t); }));
const gclass = t => GROUP[t] ? "g-" + GROUP[t] : "";
const info = t => `<span class="info" title="${esc(t)}">i</span>`;  // an explanation, on hover
const chip = (t, extra = "") => `<span class="chip ${gclass(t)} ${extra}">${esc(t)}</span>`;


// ---------- history ----------
const usedBy = {}, textHist = {};
D.history.forEach(h => {
  if (h.chant && h.chant !== "?") (usedBy[h.chant] = usedBy[h.chant] || []).push(h);
  (textHist[h.text] = textHist[h.text] || []).push(h);
});
const textTitle = {}; D.texts.forEach(t => textTitle[t.id] = t.title);
const lastUsed = id => (usedBy[id] || []).map(h => h.date).sort().pop() || "";
