$ErrorActionPreference = 'Stop'
. "$PSScriptRoot/Get-SupportSnapshot.ps1"
$script:passed = 0
function Assert-Equal($Actual, $Expected, [string]$Label) {
    if ($Actual -cne $Expected) { throw "FAIL: $Label" }
    $script:passed++
    Write-Output "PASS: $Label"
}

# Synthetic fixtures only. No dependency on this computer's capacity or services.
$rows = @(ConvertTo-DiskSummary -Disks @(
    [pscustomobject]@{Size=100GB;FreeSpace=20GB},
    [pscustomobject]@{Size=100GB;FreeSpace=15GB},
    [pscustomobject]@{Size=100GB;FreeSpace=14GB},
    [pscustomobject]@{Size=0;FreeSpace=0},
    [pscustomobject]@{Size=100GB;FreeSpace=101GB},
    [pscustomobject]@{Size=100GB;FreeSpace=-1},
    [pscustomobject]@{Size=$null;FreeSpace=$null}
))
Assert-Equal $rows.Count 7 'all disk fixtures retained'
Assert-Equal $rows[0].FreePercent 20.0 'free capacity calculation'
Assert-Equal $rows[1].Status 'OK' '15 percent boundary'
Assert-Equal $rows[2].Status 'Review' 'below 15 percent flagged'
foreach ($i in 3..6) { Assert-Equal $rows[$i].Status 'Unknown' "invalid disk fixture $i" }

function Get-CimInstance {
    param($ClassName,$Filter,$ErrorAction)
    if ($ClassName -eq 'Win32_OperatingSystem') {
        return [pscustomobject]@{Version='TEST';BuildNumber='TEST';TotalVisibleMemorySize=16777216}
    }
    return [pscustomobject]@{Size=100GB;FreeSpace=10GB;DeviceID='PRIVATE';VolumeName='PRIVATE'}
}
function Get-Service { param($Name,$ErrorAction); [pscustomobject]@{Status='Running'} }
$snapshot = Get-SupportSnapshot
Assert-Equal $snapshot.OperatingSystem.MemoryGiB 16.0 'KiB to GiB conversion'
Assert-Equal $snapshot.FixedDisks.Items.Count 1 'single disk remains an array'
Assert-Equal $snapshot.PrintSpooler.State 'Running' 'service state collected'
$json = $snapshot | ConvertTo-Json -Depth 6
Assert-Equal ($json -match 'PRIVATE|DeviceID|VolumeName') $false 'private disk identifiers omitted'
$roundTrip = $json | ConvertFrom-Json
Assert-Equal $roundTrip.SchemaVersion '1.0' 'JSON round trip'

function Get-CimInstance { param($ClassName,$Filter,$ErrorAction); throw 'PRIVATE exception' }
function Get-Service { param($Name,$ErrorAction); throw 'PRIVATE exception' }
$unavailable = Get-SupportSnapshot
Assert-Equal $unavailable.OperatingSystem.Status 'Unavailable' 'OS failure recorded'
Assert-Equal $unavailable.FixedDisks.Status 'Unavailable' 'disk failure recorded'
Assert-Equal $unavailable.PrintSpooler.Status 'Unavailable' 'service failure recorded'
Assert-Equal (($unavailable | ConvertTo-Json -Depth 6) -match 'PRIVATE') $false 'raw errors omitted'
Write-Output "$script:passed assertions passed. Fixtures are synthetic."

