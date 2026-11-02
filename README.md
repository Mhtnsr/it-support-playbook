# It Support Playbook

IT support runbooks, PowerShell endpoint triage, incident templates, and escalation practice.

**Owner:** [Mahamat Nassour Ahmat](https://github.com/Mhtnsr) · IT Support Specialist → Systems Administrator

## Problem

Support knowledge is easily lost between tickets and technicians.

## Solution

Five focused runbooks, a read-only Windows snapshot utility, reusable user responses, and clear escalation and incident templates.

## Usage

Run from the repository root. Use an isolated, authorized environment and inspect source before execution.

```powershell
./toolkit/Get-SupportSnapshot.ps1
./toolkit/Test-SupportSnapshot.ps1
```

## Validation and limits

Snapshot: 17 synthetic assertions passed in the earlier validation. Live collectors were unavailable in the authoring environment. Runbooks are reference material; no workplace incidents or achieved SLA metrics are claimed.

## Screenshots and evidence

[Evidence checklist](evidence/README.md). Placeholder: add a sanitized capture of the actual execution or lab result here after validation. No screenshots or outcomes are fabricated.

<!-- Example after creating the file: ![Sanitized lab result](evidence/lab-result.png) -->

## Repository map

Source belongs in `scripts/`, reproducible checks in `tests/`, synthetic inputs in `examples/`, design notes in `docs/`, reusable records in `templates/`, and sanitized proof in `evidence/`. Only directories relevant to this project are created.

## Next steps

- Capture a reproducible lab run with expected versus observed behavior.
- Document failure cases and recovery or escalation.
- Update validation status only after recording actual results.

## Security

See [SECURITY.md](SECURITY.md). No company data, credentials, internal topology, or live ticket details belong here.

## License

[MIT](LICENSE). A personal learning project; not affiliated with or endorsed by USEReady, Microsoft, CompTIA, or other vendors.
