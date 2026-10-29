"use strict";
const D = window.PSALTER;
const $ = (s, el = document) => el.querySelector(s);
const ymd = (d = new Date()) => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;   // today here, not in London
// a click that lands while a field's change redraws the page (the button under the pointer is replaced) still counts
let pressed = null;
document.addEventListener("pointerdown", e => { const el = e.target.closest("[onclick]"); pressed = el ? {el, code: el.getAttribute("onclick")} : null; }, true);
document.addEventListener("pointerup", () => {
  const p = pressed; pressed = null;
  if (!p || p.el.isConnected) return;
  const again = [...document.querySelectorAll("[onclick]")].find(x => x.getAttribute("onclick") === p.code);
  if (again) setTimeout(() => again.click(), 0);
}, true);
const esc = s => String(s ?? "").replace(/[&<>"]/g, c => ({"&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;"}[c]));

// ---------- vocabulary ----------
const GROUP = {}; const ORDER = [];
D.vocabulary.forEach(g => g.tags.forEach(t => { GROUP[t] = g.group; ORDER.push(t); }));
const gclass = t => GROUP[t] ? "g-" + GROUP[t] : "";
const info = t => `<span class="info" title="${esc(t)}">i</span>`;  // an explanation, on hover
// a side pane that folds away to a narrow strip (‹ / ›), remembered for each tab in this browser
const folded = name => { try { return localStorage.getItem("psalter-fold-" + name) === "1"; } catch (e) { return false; } };
const layoutOpen = name => `<div class="layout ${folded(name) ? "folded" : ""}"><aside><button class="small fold" onclick="foldPane(this, '${name}')" ${foldTitle(folded(name))}>${folded(name) ? "›" : "‹"}</button>`;
const foldTitle = on => `title="${on ? "Show" : "Hide"} this pane" aria-expanded="${!on}"`;
function foldPane(btn, name) {
  const lay = btn.closest(".layout"), on = lay.classList.toggle("folded");
  btn.textContent = on ? "›" : "‹"; btn.title = (on ? "Show" : "Hide") + " this pane"; btn.setAttribute("aria-expanded", String(!on));
  try { localStorage.setItem("psalter-fold-" + name, on ? "1" : "0"); } catch (e) {}
}
const chip = (t, extra = "") => `<span class="chip ${gclass(t)} ${extra}">${esc(t)}</span>`;


// ---------- history ----------
const usedBy = {}, textHist = {};
D.history.forEach(h => {
  if (h.chant && h.chant !== "?") (usedBy[h.chant] = usedBy[h.chant] || []).push(h);
  (textHist[h.text] = textHist[h.text] || []).push(h);
});
const textTitle = {}; D.texts.forEach(t => textTitle[t.id] = t.title);
const lastUsed = id => (usedBy[id] || []).map(h => h.date).sort().pop() || "";
