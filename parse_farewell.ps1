$content = Get-Content -Path "achi-list\AFarewellToArms.lua" -Raw
$achievements = @{}
$current = $null
$currentIndent = -1
$inCriteria = $false
foreach ($line in ($content -split "`r?`n")) {
    if ($line -match '"criteria"') { $inCriteria = $true }
    elseif ($line -match '"children"') { $inCriteria = $false }
    if ($line -match '^\s*\[\"id\"\]\s*=\s*(\d+)') {
        $id = [int]$Matches[1]
        $indent = ($line -replace '^(\s*).*','$1').Length
        if ($id -gt 0) {
            if ($inCriteria -and $current -ne $null -and $indent -gt $currentIndent) {
                if (-not $achievements[$current].criteria) { $achievements[$current].criteria = @() }
                $achievements[$current].criteria += $id
            } else {
                $current = $id
                $currentIndent = $indent
                $inCriteria = $false
                if (-not $achievements[$id]) { $achievements[$id] = @{ criteria = @() } }
            }
        }
    }
}
$ids = $achievements.Keys | Sort-Object
$out = @()
foreach ($id in $ids) {
    $out += "    -- A Farewell to Arms: achievement $id"
    $out += "    [$id] = {"
    $out += '        helpText = "",'
    $crit = $achievements[$id].criteria
    if ($crit -and $crit.Count -gt 0) {
        $out += "        criteria = {"
        foreach ($c in $crit) { $out += "            [$c] = { helpText = `"`", waypoints = {} }," }
        $out += "        }"
    }
    $out += "    },"
    $out += ""
}
$out | Out-File -FilePath "achi-list\AFarewellToArms_waypoints_output.txt" -Encoding utf8
Write-Host "Parsed $($ids.Count) achievements"
