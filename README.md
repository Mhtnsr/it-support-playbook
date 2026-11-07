# IT support playbook

Personal troubleshooting notes and small support tools. The goal is to connect a user's symptom to a useful check, a focused change, and verification of the original task.

## Find a runbook

| Symptom | Guide |
| --- | --- |
| No network connection | [Connectivity](runbooks/01-network-connectivity.md) |
| Names do not resolve | [DNS](runbooks/02-dns-resolution.md) |
| Account keeps locking | [Account lockout](runbooks/03-account-lockout.md) |
| Print jobs do not arrive | [Printers](runbooks/04-printer-troubleshooting.md) |
| Windows device feels slow | [Performance](runbooks/05-slow-windows-device.md) |

These are reference guides, not records of resolved workplace incidents. Actual incident reports will need their own symptoms, observations, changes, and results.

## Endpoint snapshot

[Get-SupportSnapshot.ps1](toolkit/Get-SupportSnapshot.ps1) collects a small read-only JSON report: OS version, memory capacity, fixed-disk free space, and print spooler state. It excludes hostnames, usernames, network addresses, and disk labels.

```powershell
./toolkit/Get-SupportSnapshot.ps1
./toolkit/Test-SupportSnapshot.ps1
```

The fixture-based suite covers calculation, serialization, missing data, and collector failures. The live collectors were unavailable in the authoring environment, so real Windows endpoint collection remains to be tested. [Usage and limitations](toolkit/README.md) · [Validation record](docs/validation.md).

## Ticket documentation

- [Incident record](templates/incident-template.md): impact, evidence, hypotheses, change, verification, and handoff.
- [User responses](templates/user-responses.md): acknowledgment, progress, resolution, and escalation wording.

Use synthetic examples in public write-ups. Real ticket details, account identifiers, and employer records stay outside this repository.

## Next exercise

Run one guide in an isolated test environment and write up expected versus observed behavior. The [lab roadmap](labs/ROADMAP.md) lists possible exercises; it is not a completion record. [Evidence index](evidence/README.md).

[MIT license](LICENSE) · [Security](SECURITY.md)

## Automated checks

[CI configuration and limits](docs/ci.md) · [Latest workflow runs](https://github.com/Mhtnsr/it-support-playbook/actions/workflows/checks.yml)
