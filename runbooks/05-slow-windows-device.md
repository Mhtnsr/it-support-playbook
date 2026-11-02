# Runbook 05: Slow Windows device

**Type:** Reference guide. No performance improvement is claimed.

## Triage

Turn “slow” into a specific symptom: sign-in, application launch, file access, browser response, or general responsiveness. Record when it occurs, recent changes, power state, and whether others are affected.

## Investigation

| Area | Evidence to gather | Interpretation |
| --- | --- | --- |
| CPU and memory | Task Manager observations during the symptom | Identify sustained pressure and the associated process |
| Storage | Free space, disk activity, health alerts | Distinguish low capacity from sustained I/O or device problems |
| Startup | Enabled startup applications and sign-in behavior | Look for unnecessary startup load |
| Updates | Pending updates and restart state | Check whether maintenance overlaps with the symptom |
| Application | Compare another app and a new test document | Isolate application-specific behavior |
| Network | Compare local and approved remote resources | Separate endpoint performance from remote-service latency |

## Example Windows capacity check

```powershell
Get-Volume |
    Select-Object DriveLetter,FileSystemLabel,SizeRemaining,Size
```

Volumes without drive letters may appear. This check reports capacity, not disk health or a definitive performance cause.

## Resolution approach

Make one justified change at a time. Close an identified application with user consent, complete approved updates, or adjust unnecessary startup items under policy. Protect unsaved work before restarting.

Do not disable security tools, delete unknown files, or run bulk cleanup commands to chase an unverified cause. Escalate hardware health alerts and suspected malicious activity.

## Verification

Repeat the original slow task under comparable conditions. Record elapsed times only when actually measured, along with the conditions and remaining limitations. A single faster attempt is not proof of a lasting fix.

## Suggested lab

Measure a harmless local task before and after an approved startup configuration change on a disposable VM. Record repeat measurements and avoid generating uncontrolled resource exhaustion.

