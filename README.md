# IT Support Toolkit & Troubleshooting Playbook

**Collect evidence. Diagnose the issue. Verify the recovery.**

A practical support portfolio by [Mhtnsr](https://github.com/Mhtnsr), combining PowerShell automation with structured service desk documentation.

## Featured: Windows Support Snapshot

A read-only PowerShell utility that collects a small JSON report for endpoint triage: OS version, memory capacity, disk free space, and spooler state.

**17 automated assertions passed** using synthetic fixtures and mocked collectors. A direct smoke run produced valid JSON with unavailable collector statuses; live endpoint collection still needs lab validation.

[Get started](toolkit/README.md) · [Source code](toolkit/Get-SupportSnapshot.ps1) · [Tests](toolkit/Test-SupportSnapshot.ps1) · [Synthetic example](toolkit/sample-output.json)

## Troubleshooting library

| User reports | Guide | Main investigation |
| --- | --- | --- |
| “I can't get online.” | [Connectivity](runbooks/01-network-connectivity.md) | Link, addressing, gateway, service path |
| “Websites won't open.” | [DNS](runbooks/02-dns-resolution.md) | Resolver configuration, query results, expected record |
| “My account keeps locking.” | [Account lockout](runbooks/03-account-lockout.md) | Account state, failed sign-ins, stale credentials |
| “My print job never arrives.” | [Printers](runbooks/04-printer-troubleshooting.md) | Device, queue, job, spooler, application |
| “My computer is slow.” | [Windows performance](runbooks/05-slow-windows-device.md) | CPU, memory, storage, startup, remote resources |

## A useful handoff

Use the [incident template](templates/incident-template.md) to record impact, actual observations, hypotheses, changes, verification, and the next action. Good notes explain why a check mattered and what its result established.

## Evidence and status

| Material | Current status |
| --- | --- |
| PowerShell toolkit | Implemented; 17 fixture-based assertions passed |
| Live endpoint collection | Requires dedicated lab validation |
| Runbooks | Reference documentation; not completed workplace incidents |
| Sample JSON | Synthetic illustration |
| Windows & Active Directory labs | [Planned](labs/ROADMAP.md) |

Commands are examples for authorized environments. Replace placeholders and follow local change and access procedures. Public evidence should use lab data and exclude credentials, employer records, and identifiable user information.

## Repository map

```text
toolkit/       PowerShell source, tests, usage, and sample JSON
runbooks/      Five focused troubleshooting guides
templates/     Incident documentation template
labs/          Planned hands-on exercises and evidence standards
```

[Back to my profile](https://github.com/Mhtnsr)
