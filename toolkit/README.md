# Windows Support Snapshot

A small PowerShell utility that gathers consistent endpoint facts before troubleshooting or escalation.

## The support problem

“The computer is slow” and “printing is broken” are symptoms, not diagnoses. A first-line technician needs a repeatable way to capture basic endpoint state without changing the device or copying unnecessary identifiers into a ticket.

This tool returns a structured snapshot that can be reviewed alongside the user's symptoms and the relevant runbook.

## Run

On an authorized Windows device, open PowerShell in this folder:

```powershell
.\Get-SupportSnapshot.ps1
```

To save a local report:

```powershell
.\Get-SupportSnapshot.ps1 | Set-Content -LiteralPath .\snapshot.json -Encoding utf8
```

The script does not bypass execution policy. Follow your environment's approved script execution process. CIM and service access depend on permissions and available Windows components. PowerShell 5.1+ syntax is used; validation so far was performed with PowerShell 7, not a full OS/version matrix.

## What the report means

| Field | Collected information | Practical limit |
| --- | --- | --- |
| OperatingSystem | Version, build, visible memory capacity | Does not measure memory pressure or update compliance |
| FixedDisks | Capacity, available space, percentage available | Does not measure disk health or I/O latency |
| PrintSpooler | Service state | Running does not prove printing works |
| Status: Unavailable | The check could not collect data | Does not imply that the underlying component failed |
| Disk status: Review | Available space is below 15% | A triage threshold, not a diagnosis |

Disk rows use numeric labels. They intentionally omit drive letters and volume labels, so this report cannot identify a particular drive for remediation. A technician can perform a separate authorized inspection when needed. Invalid capacity data produces `Unknown`, not a misleading percentage.

## Design decisions

- **Read-only by default:** no repair commands, settings changes, service restarts, or outbound requests.
- **Partial results:** one failed check does not discard other successful checks.
- **Small data footprint:** excludes hostnames, usernames, serial numbers, IP/MAC addresses, paths, and raw exception messages.
- **JSON output:** easy to inspect or consume in a later workflow; one schema version identifies the format.
- **No automatic upload:** review reports before sharing. Even a minimal report contains device characteristics.

## Example output

See [sample-output.json](sample-output.json). It is a synthetic illustration, not output from a real endpoint or evidence of a completed support incident.

## Validation

Run the dependency-free checks:

```powershell
.\Test-SupportSnapshot.ps1
```

**Observed result: 17 assertions passed.** Tests use synthetic fixtures and mocked collectors to check:

- Free-space math and the 15% boundary
- Zero, negative, missing, and inconsistent capacity values
- Memory unit conversion and single-disk array shape
- JSON serialization and schema version
- Exclusion of fixture disk identifiers and raw errors
- Explicit unavailable results when collection fails

A direct smoke run also emitted parseable JSON in the authoring environment. All three live collectors were unavailable there, so live endpoint collection remains unvalidated. These checks establish calculation, serialization, and fallback behavior; they do not establish compatibility with every Windows configuration.

## Use in a support ticket

1. Record the user's original task, impact, start time, and recent changes.
2. Run the snapshot on an authorized device.
3. Review results and choose a focused investigation from the [runbooks](../runbooks).
4. Document any approved changes and repeat the original task.
5. Use the [incident template](../templates/incident-template.md) for the handoff.

## Next improvements

- Validate collection on a dedicated Windows lab VM.
- Add an opt-in, locally reviewed network diagnostic section.
- Add a human-readable report formatter without changing the JSON schema.

