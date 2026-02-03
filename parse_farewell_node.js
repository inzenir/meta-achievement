const fs = require('fs');
const c = fs.readFileSync('achi-list/AFarewellToArms.lua', 'utf8');
const achievements = {};
let current = null;
let inCriteria = false;
for (const line of c.split(/\r?\n/)) {
  if (line.includes('"criteria"')) inCriteria = true;
  else if (line.includes('"children"')) inCriteria = false;
  const m = line.match(/\[\"id\"\]\s*=\s*(\d+)/);
  if (m) {
    const id = parseInt(m[1], 10);
    if (id > 0) {
      if (inCriteria && current) {
        (achievements[current].criteria = achievements[current].criteria || []).push(id);
      } else {
        current = id;
        if (!achievements[id]) achievements[id] = {};
      }
    }
  }
}
const ids = Object.keys(achievements).map(Number).sort((a, b) => a - b);
let out = '';
for (const id of ids) {
  const crit = achievements[id].criteria || [];
  out += '    -- A Farewell to Arms: achievement ' + id + '\n    [' + id + '] = {\n        helpText = "",\n';
  if (crit.length) {
    out += '        criteria = {\n';
    for (const cid of crit) out += '            [' + cid + '] = { helpText = "", waypoints = {} },\n';
    out += '        }\n';
  }
  out += '    },\n\n';
}
fs.writeFileSync('achi-list/AFarewellToArms_waypoints_output.txt', out);
console.log('Parsed', ids.length, 'achievements');
