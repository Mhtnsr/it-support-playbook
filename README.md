# IT Support Troubleshooting Playbook

**Practical troubleshooting. Clear handoffs. Reliable user support.**

A portfolio knowledge base by [Mhtnsr](https://github.com/Mhtnsr), organized around common service desk problems and a repeatable support process.

## Start here

| User reports | Guide |
| --- | --- |
| “I can't get online.” | [Network connectivity](runbooks/01-network-connectivity.md) |
| “The network works, but websites won't open.” | [DNS resolution](runbooks/02-dns-resolution.md) |
| “My account keeps locking.” | [Account lockout](runbooks/03-account-lockout.md) |
| “My print job never arrives.” | [Printer troubleshooting](runbooks/04-printer-troubleshooting.md) |
| “My computer is slow.” | [Slow Windows device](runbooks/05-slow-windows-device.md) |

Use the [incident template](templates/incident-template.md) to document an investigation. See the [lab roadmap](labs/ROADMAP.md) for planned hands-on evidence.

## Status and scope

These are reference runbooks and learning materials, not claims of completed incidents or verified lab results. Commands are examples for an authorized Windows test environment. Adapt steps to the operating system, privileges, and organization policy.

Completed lab reports will be added separately with environment details, actual observations, and verification evidence.

## Support workflow

1. Establish the symptom, business impact, scope, and start time.
2. Gather relevant evidence before changing the system.
3. Compare working and affected components to narrow the cause.
4. Apply one focused, authorized change at a time.
5. Repeat the user's original task to verify recovery.
6. Record the cause, resolution, verification, and escalation notes.

## Documentation principles

- Separate observations from hypotheses.
- Capture errors accurately and record the time.
- Explain why each check matters.
- Use synthetic examples and sanitized screenshots in public reports.
- Keep passwords, tokens, employer records, and identifiable user data out of this repository.
- Record unsuccessful checks when they help the next technician avoid repeating work.

## Suggested reading order

Start with network connectivity, then DNS. Continue with accounts, printers, and performance. Complete one lab scenario with evidence before marking it as completed.

[Back to my profile](https://github.com/Mhtnsr)
