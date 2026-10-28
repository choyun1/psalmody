// ---------- playback ----------
let audio = null, playing = null, playId = 0;     // playId: which playback is current, so an old one's timer can't stop a new one
function stopPlay() { playId++; if (playing) { playing.forEach(o => { try { o.stop(); } catch (e) {} }); playing = null; } document.querySelectorAll(".play").forEach(b => b.textContent = "▶ Play"); }
function play(id, btn, shift = 0) {
  const v = shift ? Object.fromEntries(Object.entries(C[id].voices).map(([k, evs]) => [k, evs.map(([m, a, b]) => [m + shift, a, b])])) : C[id].voices;
  playVoices(v, btn);
}
function playTone(name, btn) { playVoices((D.tones || []).find(t => t.name === name).voices, btn); }
function playVoices(voices, btn) {
  if (playing) { const was = btn.textContent.startsWith("■"); stopPlay(); if (was) return; }
  audio = audio || new (window.AudioContext || window.webkitAudioContext)();
  const c = {voices}, wn = 2.09;                // seconds per whole note (raise to slow down)
  const t0 = audio.currentTime + 0.08, out = audio.createGain(); out.gain.value = 0.11; out.connect(audio.destination);
  const lp = audio.createBiquadFilter(); lp.type = "lowpass"; lp.frequency.value = 2400; lp.connect(out);
  playing = []; let end = 0;
  Object.entries(c.voices).forEach(([v, evs]) => {
    if (v === "descant") return;
    evs.forEach(([m, st, du]) => {
      const f = 440 * Math.pow(2, (m - 57) / 12), a = t0 + st * wn, b = a + du * wn;
      end = Math.max(end, b);
      const g = audio.createGain(); g.gain.setValueAtTime(0, a); g.gain.linearRampToValueAtTime(1, a + 0.04);
      g.gain.setValueAtTime(1, b - 0.06); g.gain.linearRampToValueAtTime(0, b); g.connect(lp);
      [[1, 1], [2, .45], [3, .18], [4, .12]].forEach(([h, amp]) => {
        const o = audio.createOscillator(), og = audio.createGain(); o.frequency.value = f * h; og.gain.value = amp;
        o.connect(og); og.connect(g); o.start(a); o.stop(b + 0.02); playing.push(o);
      });
    });
  });
  btn.textContent = "■ Stop";
  const me = ++playId;
  setTimeout(() => { if (me === playId) stopPlay(); }, (end - audio.currentTime + 0.2) * 1000);
}
