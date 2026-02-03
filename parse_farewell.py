# Parse AFarewellToArms.lua and output waypoint entries for AWorldAwoken.waypoints.lua
import re

with open("achi-list/AFarewellToArms.lua", "r", encoding="utf-8") as f:
    content = f.read()

achievements = {}
current_achievement = None
in_criteria = False

for line in content.splitlines():
    achievement_id = re.search(r'\[\"id\"\]\s*=\s*(\d+)', line)
    criteria_marker = '"criteria"' in line
    children_marker = '"children"' in line

    if criteria_marker:
        in_criteria = True
    elif children_marker:
        in_criteria = False

    if achievement_id:
        id_val = int(achievement_id.group(1))
        if id_val > 0:
            if in_criteria and current_achievement is not None:
                if "criteria" not in achievements[current_achievement]:
                    achievements[current_achievement]["criteria"] = []
                achievements[current_achievement]["criteria"].append(id_val)
            else:
                current_achievement = id_val
                if id_val not in achievements:
                    achievements[id_val] = {}

sorted_ids = sorted(achievements.keys())
output_lines = []
for id_val in sorted_ids:
    output_lines.append(f"    -- A Farewell to Arms: achievement {id_val}")
    output_lines.append(f"    [{id_val}] = {{")
    output_lines.append('        helpText = "",')
    criteria = achievements[id_val].get("criteria", [])
    if criteria:
        output_lines.append("        criteria = {")
        for cid in criteria:
            output_lines.append(f'            [{cid}] = {{ helpText = "", waypoints = {{}} }},')
        output_lines.append("        }")
    output_lines.append("    },")
    output_lines.append("")

with open("achi-list/AFarewellToArms_waypoints_output.txt", "w", encoding="utf-8") as f:
    f.write("\n".join(output_lines))

print(f"Parsed {len(sorted_ids)} achievements from A Farewell to Arms")
for id_val in sorted_ids:
    c = achievements[id_val].get("criteria", [])
    print(f"  {id_val}" + (f" ({len(c)} criteria)" if c else ""))
