# Windows snapshot: hosted-runner validation

Date: November 7, 2026. Environment: a disposable GitHub-hosted Windows Server 2025 runner.

## Goal

Check that the endpoint snapshot utility can read actual Windows OS and disk data, serialize its documented schema, and omit identifying report fields. This is a validation exercise, not an incident-resolution story.

## Execution

The [passing workflow run](https://github.com/Mhtnsr/it-support-playbook/actions/runs/42377812444) tested source commit `31286e4ddfb002c850bf68fb4440c4ed49c5dbfd` in two separate jobs: Windows PowerShell and PowerShell 7. Each ran the fixture checks followed by `toolkit/Test-WindowsSnapshot.ps1`.

The [PowerShell 7 job](https://github.com/Mhtnsr/it-support-playbook/actions/runs/42377812444/job/128418916594) produced the [captured report](windows-runner-snapshot.json). Only the snapshot JSON block was copied, after its fields passed the allowlist. Checkout logs, runner IDs, temporary paths, and authentication setup were excluded from this evidence file.

## Observed results

| Check | Observed result |
| --- | --- |
| Fixture suite | 17 assertions passed per runtime |
| Live OS collection | Collected; version 10.0.26100, build 26100 |
| Memory capacity | 15.99 GiB visible to the runner |
| Fixed disks | 2 collected; capacities and percentages passed range checks |
| Print spooler | Collected; Running |
| Output shape | Exact report-field allowlist passed |
| System changes | None requested by the snapshot or live check |

## Interpretation

This closes the earlier gap where every collector was unavailable in the restricted authoring environment. The collection code now has an observed successful Windows execution, not only mocked unit coverage.

The result does not diagnose slow storage, prove printing works, or establish Windows 11/MDM compatibility. A running spooler is only a service-state observation. Disk free space and memory capacity are not performance measurements.

## Next personal exercise

Run the same checks on an owned disposable Windows VM using the [home-lab exercise](https://github.com/Mhtnsr/homelab/blob/main/docs/first-windows-exercise.md), compare with Windows' own displays, and record actual observations and a sanitized screenshot. No personal home-lab execution is claimed here.
