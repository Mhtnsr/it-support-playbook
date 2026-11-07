<# Live, read-only integration check. Intended for an owned Windows test device
   or a disposable GitHub-hosted Windows runner. Does not restart services or
   change settings. Prints only the snapshot's validated, allowlisted fields. #>
$ErrorActionPreference = 'Stop'
$snapshot = & "$PSScriptRoot/Get-SupportSnapshot.ps1" | ConvertFrom-Json

function Assert-Properties($Object, [string[]]$Expected) {
    $actual = @($Object.PSObject.Properties.Name | Sort-Object)
    if (Compare-Object $actual @($Expected | Sort-Object)) {
        throw 'Unexpected report fields; output withheld.'
    }
}

Assert-Properties $snapshot @('SchemaVersion','CollectedAtUtc','OperatingSystem','FixedDisks','PrintSpooler')
Assert-Properties $snapshot.OperatingSystem @('Status','Version','Build','MemoryGiB')
Assert-Properties $snapshot.FixedDisks @('Status','Items')
Assert-Properties $snapshot.PrintSpooler @('Status','State')
if ($snapshot.SchemaVersion -ne '1.0') { throw 'Unexpected schema.' }
if ($snapshot.OperatingSystem.Status -ne 'Collected' -or
    [string]::IsNullOrWhiteSpace($snapshot.OperatingSystem.Version) -or
    $snapshot.OperatingSystem.MemoryGiB -le 0) {
    throw 'Live operating-system collection did not succeed.'
}
if ($snapshot.FixedDisks.Status -ne 'Collected' -or @($snapshot.FixedDisks.Items).Count -lt 1) {
    throw 'Live fixed-disk collection did not succeed.'
}
foreach ($disk in $snapshot.FixedDisks.Items) {
    Assert-Properties $disk @('Disk','CapacityGiB','FreeGiB','FreePercent','Status')
    if ($disk.CapacityGiB -le 0 -or $disk.FreeGiB -lt 0 -or
        $disk.FreeGiB -gt $disk.CapacityGiB -or
        $disk.FreePercent -lt 0 -or $disk.FreePercent -gt 100 -or
        $disk.Status -notin @('OK','Review')) {
        throw 'Invalid live disk summary.'
    }
}
if ($snapshot.PrintSpooler.Status -notin @('Collected','Unavailable')) {
    throw 'Unexpected spooler status.'
}
# A runner may not provide a spooler. Collection state is recorded, not repaired.
$snapshot | ConvertTo-Json -Depth 6
Write-Output 'PASS: live Windows OS and fixed-disk collection; report field allowlist verified.'
