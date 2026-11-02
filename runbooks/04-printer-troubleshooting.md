# Runbook 04: Printer troubleshooting

**Type:** Reference guide. No execution results are claimed.

## Triage

Record the printer, error, connection type, affected application, and whether other users can print. Determine whether one document, one queue, or the physical printer is affected.

## Investigation

1. Check power, paper, toner, visible errors, and physical connectivity.
2. Confirm the selected queue matches the intended printer.
3. Inspect paused or offline status and stuck jobs.
4. Compare with a known-good workstation or a different approved queue.
5. Test a simple document to distinguish document-specific failures.
6. Check queue configuration, driver version, and print server status with the authorized owner.

## Example Windows checks

```powershell
Get-Printer
Get-Service -Name Spooler
Get-PrintJob -PrinterName '<printer-name>'
```

Replace the printer placeholder with the exact queue name. The PrintManagement commands require the module to be available and appropriate permissions. These checks inspect state.

## Resolution approach

Correct the specific fault. Obtain approval before canceling another user's job, reinstalling a driver, or restarting a shared service. Restarting the spooler can affect multiple print jobs; do not make it the default first step. Avoid clearing entire queues without understanding their ownership and impact.

## Verification

Print a test page and the original document when appropriate. Confirm the output reaches the intended device and the queue clears normally.

## Escalation packet

Include the queue and device model, error text, scope, timestamps, driver details, tests performed, and whether the printer's own diagnostic page works. Sanitize these details before publishing a lab report.

## Suggested lab

Use a local test queue or virtual printer to compare normal printing with a paused queue. Restore the initial state and capture the observed behavior.

