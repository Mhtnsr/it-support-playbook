# Hosted CI validation — November 7, 2026

**Observed result: all jobs passed.**

[Inspect the run](https://github.com/Mhtnsr/it-support-playbook/actions/runs/42377812444) · tested source commit: `31286e4ddfb002c850bf68fb4440c4ed49c5dbfd`.

| Job | Result |
| --- | --- |
| Windows / pwsh | success |
| Windows / powershell | success |

## Scope

Each job runs 17 fixture assertions plus a separate live OS/disk snapshot check on its disposable Windows runner.

These are GitHub-hosted runner results. They are not evidence of a personal home-lab build, an employer deployment, or a resolved customer incident. Later runs can have different results; inspect the [workflow history](https://github.com/Mhtnsr/it-support-playbook/actions/workflows/checks.yml) for current status.

## What changed during setup

The first PowerShell workflow definition failed validation because a matrix expression was not supported in the shell field. It was changed to two explicit runtime jobs; the linked run is the corrected passing result. The Python workflows passed their first runs.
