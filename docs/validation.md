# Local validation record

Date: November 1, 2026 (America/New_York).

Environment: Windows authoring workspace; PowerShell 7 for PowerShell checks and Python 3.12 for Python checks. These are local test results, not a CI result or a completed production incident.

## Scope

The snapshot suite uses synthetic fixtures and mocked collectors. It validates logic and output shape. Live collection previously returned unavailable statuses in this environment; compatibility with a real Windows lab endpoint remains unverified.

## Observed output

```text
PASS: all disk fixtures retained
PASS: free capacity calculation
PASS: 15 percent boundary
PASS: below 15 percent flagged
PASS: invalid disk fixture 3
PASS: invalid disk fixture 4
PASS: invalid disk fixture 5
PASS: invalid disk fixture 6
PASS: KiB to GiB conversion
PASS: single disk remains an array
PASS: service state collected
PASS: private disk identifiers omitted
PASS: JSON round trip
PASS: OS failure recorded
PASS: disk failure recorded
PASS: service failure recorded
PASS: raw errors omitted
17 assertions passed. Fixtures are synthetic.
```

## Reproduce

Run the test command in this repository's README. A passing suite establishes only the cases represented in the tests; add actual lab evidence before claiming end-to-end deployment or recovery.
