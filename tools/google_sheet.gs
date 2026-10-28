/**
 * Psalter: lets the Service planner read and write the music schedule (this Google Sheet).
 *
 * Set up once (as the account that owns the sheet):
 *   1. In the sheet: Extensions > Apps Script. Replace everything there with this file. Save.
 *   2. Deploy > New deployment > type "Web app". Execute as: Me. Who has access: Anyone.
 *      Deploy, allow access when Google asks, and copy the web app URL.
 *   3. Paste that URL into "Connect the Google Sheet" in the planner.
 * The planner only gets in with the secret below, which it made for you; anyone without it is refused.
 *
 * If your Google Workspace doesn't allow "Anyone" (only people in your organization), use the menu
 * instead: reload the sheet, and a "Psalter" menu appears with "Record a service from the planner…":
 * paste what the planner's "Copy for the sheet" gives you, check the changes, write them.
 *
 * Also here: fixHymnLinks(). Run it once from this editor (choose it in the toolbar, then Run): every
 * cell naming a hymn, e.g. "390 (EH1982)", whose link points to another hymn or covers only part of
 * the text gets one link on the whole cell to that hymn on hymnary.org (the first hymn, when a cell
 * names several). Each change is listed, with a link to the cell, under Execution log.
 * addMissingHymnLinks() does the same and also links hymn cells that have no link at all.
 *
 * LAYOUT is how this sheet is laid out, from the spreadsheet_ lines of parish.txt when the planner made
 * this copy (the planner also sends its current settings with every request).
 */
const SECRET = '__SECRET__';
const LAYOUT = __LAYOUT__;
let L = LAYOUT;
function useLayout_(q) { L = Object.assign({}, LAYOUT, (q && q.layout) || {}); }

function linkFor(text) {
  if (!L.hymnRe) return null;
  const m = String(text || '').match(new RegExp(L.hymnRe));
  if (!m) return null;
  const book = L.hymnary[(m.groups && m.groups.b) || 'EH1982'] || 'EH1982';
  return 'https://hymnary.org/hymn/' + book + '/' + m.groups.n.toLowerCase();
}

function setCell(range, value) {
  const text = value == null ? '' : String(value);
  const link = linkFor(text);
  if (!text) { range.clearContent(); return; }
  const rt = SpreadsheetApp.newRichTextValue().setText(text);
  if (link) rt.setLinkUrl(link);
  range.setRichTextValue(rt.build());
}

function ymd(d) {
  return Utilities.formatDate(d, SpreadsheetApp.getActive().getSpreadsheetTimeZone(), 'yyyy-MM-dd');
}

function dateColumns(sheet) {
  const row = sheet.getRange(1, 1, 1, sheet.getLastColumn()).getValues()[0];
  const out = [];
  row.forEach((v, i) => { if (v instanceof Date) out.push({col: i + 1, date: ymd(v)}); });
  return out;
}

function labels(sheet) {
  const vals = sheet.getRange(1, 1, Math.max(sheet.getLastRow(), 1), 1).getValues();
  const out = {};
  vals.forEach((r, i) => { const l = String(r[0] || '').trim(); if (l && !(l in out)) out[l] = i + 1; });
  return out;
}

function tabName_(year) { return L.tabs.split('{year}').join(String(year)); }

/** The tab a new one is modelled on: the latest year's (or the one tab, when the name has no {year}). */
function latestTab_() {
  const ss = SpreadsheetApp.getActive();
  if (L.tabs.indexOf('{year}') < 0) {
    const one = ss.getSheetByName(L.tabs);
    if (!one) throw new Error('This spreadsheet has no tab named "' + L.tabs + '" (spreadsheet_tabs: in parish.txt).');
    return one;
  }
  const esc = L.tabs.replace(/[.*+?^${}()|[\]\\]/g, '\\$&').split('\\{year\\}').join('(\\d{4})');
  const re = new RegExp('^' + esc + '$');
  const tabs = ss.getSheets().filter(s => re.test(s.getName()))
    .sort((a, b) => Number(b.getName().match(re)[1]) - Number(a.getName().match(re)[1]));
  if (!tabs.length) throw new Error('This spreadsheet has no tab named like "' + L.tabs + '" (spreadsheet_tabs: in parish.txt).');
  return tabs[0];
}

function yearSheet(year, create) {
  const ss = SpreadsheetApp.getActive();
  let sh = ss.getSheetByName(tabName_(year));
  if (sh || !create) return sh;
  const model = latestTab_();
  sh = model.copyTo(ss).setName(tabName_(year));
  const lastCol = sh.getLastColumn(), lastRow = sh.getLastRow();
  if (lastCol > 1) sh.getRange(1, 2, lastRow, lastCol - 1).clearContent();   // keep the layout, no services
  ss.setActiveSheet(sh);
  ss.moveActiveSheet(1);                                                      // newest year first
  return sh;
}

/** The column for a date, made (in date order, laid out like its neighbour) if the sheet hasn't one. */
function columnFor(sheet, date, create) {
  const cols = dateColumns(sheet);
  const hit = cols.find(c => c.date === date);
  if (hit || !create) return hit ? hit.col : null;
  const d = date.split('-').map(Number), stamp = new Date(d[0], d[1] - 1, d[2]);
  if (!cols.length) { sheet.getRange(1, 2).setValue(stamp); return 2; }
  const width = cols.length > 1 ? cols[1].col - cols[0].col : (L.width || 1);
  const later = cols.find(c => c.date > date);
  const rows = sheet.getMaxRows();
  if (!later) {
    const at = cols[cols.length - 1].col + width;
    if (at + width - 1 > sheet.getMaxColumns()) sheet.insertColumnsAfter(sheet.getMaxColumns(), width);
    if (sheet.getRange(1, at).getValue() === '') {
      if (!sheet.getRange(1, at).isPartOfMerge())
        sheet.getRange(1, cols[cols.length - 1].col, rows, width).copyTo(sheet.getRange(1, at, rows, width), SpreadsheetApp.CopyPasteType.PASTE_FORMAT, false);
      sheet.getRange(1, at).setValue(stamp);
      return at;
    }
  }
  const at = later.col;
  sheet.insertColumnsBefore(at, width);
  sheet.getRange(1, at + width, rows, width).copyTo(sheet.getRange(1, at, rows, width), SpreadsheetApp.CopyPasteType.PASTE_FORMAT, false);
  for (let k = 0; k < width; k++) sheet.setColumnWidth(at + k, sheet.getColumnWidth(at + width + k));
  sheet.getRange(1, at).setValue(stamp);
  return at;
}

/** A row name in the sheet -> the name the planner uses for it (spreadsheet_rows: in parish.txt). */
function canon(l) { l = String(l).trim(); return (L.rows || {})[l.toLowerCase()] || l; }

/** Open the web app's address in a browser to check it can be reached: it answers {"ok": true, …}. */
function doGet() {
  return reply({ok: true, psalter: true, title: SpreadsheetApp.getActive().getName(),
                note: 'The Psalter planner can reach this sheet. (It writes only with its secret.)'});
}

/** The "Psalter" menu, for writing without the web app (paste from the planner). */
function onOpen() {
  SpreadsheetApp.getUi().createMenu('Psalter')
    .addItem('Record a service from the planner…', 'showPasteDialog')
    .addItem('Fix hymn links', 'fixHymnLinks')
    .addToUi();
}

function showPasteDialog() {
  const html = HtmlService.createHtmlOutput(`
    <style>body{font:14px sans-serif;margin:8px} textarea{width:100%;height:120px} table{border-collapse:collapse;width:100%;margin:8px 0}
      td,th{border-bottom:1px solid #ddd;padding:3px 6px;text-align:left;vertical-align:top} .old{color:#888} button{margin-right:6px}</style>
    <p>Paste what the planner's <b>Copy for the sheet</b> gave you:</p>
    <textarea id="t"></textarea><br><button onclick="check()">Show the changes</button><div id="out"></div>
    <script>
      function check() {
        document.getElementById('out').textContent = 'Reading…';
        google.script.run.withFailureHandler(e => out(e.message)).withSuccessHandler(show).previewFromPlanner(document.getElementById('t').value);
      }
      function out(h) { document.getElementById('out').innerHTML = h; }
      function esc(x) { return String(x).replace(/[&<>]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;'}[c])); }
      function show(r) {
        if (!r.changes.length) return out('<p>The sheet already has all of this.</p>');
        out('<p>' + esc(r.where) + '</p><table><tr><th>Row</th><th>Now</th><th>Will be</th></tr>' +
          r.changes.map(c => '<tr><td>' + esc(c[0]) + '</td><td class="old">' + esc(c[1] || '(empty)') + '</td><td>' + esc(c[2]) + '</td></tr>').join('') +
          '</table>' + (r.missing.length ? '<p class="old">No row for: ' + esc(r.missing.join(', ')) + '</p>' : '') +
          '<button onclick="write_()">Write ' + r.changes.length + ' change(s)</button><button onclick="google.script.host.close()">Cancel</button>');
      }
      function write_() {
        google.script.run.withFailureHandler(e => out(e.message)).withSuccessHandler(() => { out('<p>Written.</p>'); setTimeout(() => google.script.host.close(), 900); })
          .recordFromPlanner(document.getElementById('t').value);
      }
    </script>`).setWidth(560).setHeight(480);
  SpreadsheetApp.getUi().showModalDialog(html, 'Record a service from the planner');
}

function pasted_(text) {
  let q;
  try { q = JSON.parse(text); } catch (e) { throw new Error('That isn\'t what the planner copies: click "Copy for the sheet" again.'); }
  if (!q.psalter || !q.date || !q.cells) throw new Error('That isn\'t what the planner copies.');
  useLayout_(q);
  return q;
}

function plan_(q) {
  const ss = SpreadsheetApp.getActive(), year = q.date.slice(0, 4);
  const sh = yearSheet(year, false);
  const model = sh || latestTab_();
  const lab = labels(model), byCanon = {};
  Object.keys(lab).forEach(l => { if (!(canon(l) in byCanon)) byCanon[canon(l)] = l; });
  const col = sh ? columnFor(sh, q.date, false) : null;
  const cells = Object.assign({}, q.cells);
  if (!col && q.proper) cells['Proper'] = q.proper;
  const changes = [], missing = [], write = {};
  Object.keys(cells).forEach(k => {
    const l = byCanon[canon(k)];
    if (!l) { missing.push(k); return; }
    const now = col ? sh.getRange(lab[l], col).getDisplayValue() : '';
    if (String(now).trim() !== String(cells[k]).trim()) { changes.push([l, now, cells[k]]); write[l] = cells[k]; }
  });
  return {changes, missing, write, where: 'Tab ' + tabName_(year) + ', ' + q.date + (sh ? (col ? '' : ' (a new column)') : ' (a new tab)')};
}

function previewFromPlanner(text) { const r = plan_(pasted_(text)); delete r.write; return r; }

function recordFromPlanner(text) {
  const q = pasted_(text), r = plan_(q);
  const sh = yearSheet(q.date.slice(0, 4), true), col = columnFor(sh, q.date, true), lab = labels(sh);
  Object.keys(r.write).forEach(l => setCell(sh.getRange(lab[l], col), r.write[l]));
  return true;
}

function reply(obj) {
  return ContentService.createTextOutput(JSON.stringify(obj)).setMimeType(ContentService.MimeType.JSON);
}

function doPost(e) {
  let q;
  try { q = JSON.parse(e.postData.contents); } catch (err) { return reply({ok: false, error: 'bad request'}); }
  if (q.secret !== SECRET) return reply({ok: false, error: 'wrong secret'});
  useLayout_(q);
  const lock = LockService.getScriptLock();
  lock.waitLock(20000);
  try {
    const ss = SpreadsheetApp.getActive();
    if (q.action === 'ping') return reply({ok: true, title: ss.getName()});
    const year = q.date.slice(0, 4);
    if (q.action === 'read') {
      const sh = yearSheet(year, false);
      const model = sh || latestTab_();
      const lab = labels(model);
      const col = sh ? columnFor(sh, q.date, false) : null;
      const cells = {};
      if (col) Object.keys(lab).forEach(l => { cells[l] = sh.getRange(lab[l], col).getDisplayValue(); });
      return reply({ok: true, title: ss.getName(), sheet: tabName_(year), sheetExists: !!sh, column: !!col, labels: Object.keys(lab), cells});
    }
    if (q.action === 'write') {
      const sh = yearSheet(year, true);
      const col = columnFor(sh, q.date, true);
      const lab = labels(sh);
      const done = [];
      Object.keys(q.cells).forEach(l => {
        if (!lab[l]) return;
        setCell(sh.getRange(lab[l], col), q.cells[l]);
        done.push(l);
      });
      return reply({ok: true, written: done, url: ss.getUrl() + '#gid=' + sh.getSheetId() + '&range=' + sh.getRange(1, col).getA1Notation()});
    }
    return reply({ok: false, error: 'unknown action'});
  } catch (err) {
    return reply({ok: false, error: String(err)});
  } finally {
    lock.releaseLock();
  }
}

/** Run once from the editor: every hymn cell whose link points elsewhere, or covers only part of the
 *  text, gets one link on the whole cell to the hymn it names. Lists the changes in the log. */
function fixHymnLinks() { relink_(false); }

/** Optional: also give a link to hymn cells that have none at all. */
function addMissingHymnLinks() { relink_(true); }

function relink_(addMissing) {
  const ss = SpreadsheetApp.getActive();
  let changed = 0;
  ss.getSheets().forEach(sh => {
    const last = sh.getLastRow(), lastCol = sh.getLastColumn();
    if (last < 2 || lastCol < 2) return;
    const rich = sh.getRange(1, 2, last, lastCol - 1).getRichTextValues();
    rich.forEach((row, r) => row.forEach((rt, c) => {
      if (!rt) return;
      const text = rt.getText(), want = linkFor(text);
      if (!want) return;
      const whole = rt.getLinkUrl();
      if (whole && whole.toLowerCase() === want.toLowerCase()) return;
      const any = rt.getRuns().map(x => x.getLinkUrl()).filter(Boolean);
      if (!any.length && !addMissing) return;
      const cell = sh.getRange(r + 1, c + 2);
      setCell(cell, text);
      changed++;
      Logger.log(sh.getName() + ' ' + cell.getA1Notation() + ': "' + text + '" ' + (any.length ? 'was ' + any.join(' ') : 'had no link') +
                 ', now ' + want + '   ' + ss.getUrl() + '#gid=' + sh.getSheetId() + '&range=' + cell.getA1Notation());
    }));
  });
  Logger.log(changed + ' cell(s) changed');
}
