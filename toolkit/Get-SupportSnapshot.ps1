<#
.SYNOPSIS
Collects a small, read-only Windows endpoint snapshot as JSON.
.DESCRIPTION
Reports OS version, memory capacity, fixed-disk free space, and spooler state.
Omits computer names, usernames, serial numbers, network addresses, and file paths.
Unavailable checks return explicit statuses; low free space is a triage signal,
not a diagnosis. Does not change settings, restart services, or contact a server.
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest

function ConvertTo-DiskSummary {
    param([Parameter(Mandatory)][object[]]$Disks)
    $index = 0
    foreach ($disk in $Disks) {
        $index++
        if ($null -eq $disk.Size -or $null -eq $disk.FreeSpace -or
            [double]$disk.Size -le 0 -or [double]$disk.FreeSpace -lt 0 -or
            [double]$disk.FreeSpace -gt [double]$disk.Size) {
            [pscustomobject]@{ Disk = $index; CapacityGiB = $null; FreeGiB = $null; FreePercent = $null; Status = 'Unknown' }
            continue
        }
        $percent = 100.0 * [double]$disk.FreeSpace / [double]$disk.Size
        [pscustomobject]@{
            Disk = $index
            CapacityGiB = [math]::Round([double]$disk.Size / 1GB, 2)
            FreeGiB = [math]::Round([double]$disk.FreeSpace / 1GB, 2)
            FreePercent = [math]::Round($percent, 1)
            Status = $(if ($percent -lt 15) { 'Review' } else { 'OK' })
        }
    }
}

function Get-SupportSnapshot {
    $result = [ordered]@{
        SchemaVersion = '1.0'
        CollectedAtUtc = [datetime]::UtcNow.ToString('o')
        OperatingSystem = [ordered]@{ Status = 'Unavailable'; Version = $null; Build = $null; MemoryGiB = $null }
        FixedDisks = [ordered]@{ Status = 'Unavailable'; Items = @() }
        PrintSpooler = [ordered]@{ Status = 'Unavailable'; State = $null }
    }
    try {
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop
        $memory = $null
        if ($null -ne $os.TotalVisibleMemorySize -and [double]$os.TotalVisibleMemorySize -gt 0) {
            $memory = [math]::Round([double]$os.TotalVisibleMemorySize / 1MB, 2)
        }
        $result.OperatingSystem = [ordered]@{ Status = 'Collected'; Version = [string]$os.Version; Build = [string]$os.BuildNumber; MemoryGiB = $memory }
    } catch {
        # Avoid raw exception messages, which can contain identifying data.
    }
    try {
        $disks = @(Get-CimInstance -ClassName Win32_LogicalDisk -Filter 'DriveType=3' -ErrorAction Stop)
        $items = @()
        if ($disks.Count -gt 0) { $items = @(ConvertTo-DiskSummary -Disks $disks) }
        $result.FixedDisks = [ordered]@{ Status = 'Collected'; Items = $items }
    } catch { }
    try {
        $service = Get-Service -Name Spooler -ErrorAction Stop
        $result.PrintSpooler = [ordered]@{ Status = 'Collected'; State = [string]$service.Status }
    } catch { }
    [pscustomobject]$result
}

if ($MyInvocation.InvocationName -ne '.') {
    Get-SupportSnapshot | ConvertTo-Json -Depth 6
}

