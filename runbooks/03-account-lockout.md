# Runbook 03: Account lockout

**Type:** Reference guide. No real user incident is represented.

## Triage

Verify the user's identity through the organization's approved process. Record the error, affected service, time, recent password change, and whether sign-in fails everywhere or only on one device.

Never ask for the user's password or record it in a ticket.

## Investigation

1. Distinguish lockout from an expired password, disabled account, expired account, or application authorization failure.
2. Have an authorized administrator inspect account status.
3. Identify whether repeated failed sign-ins continue after an unlock.
4. Check approved audit sources for the originating device or service.
5. Consider stale saved credentials in mobile apps, remote sessions, scheduled tasks, or services.

## Optional Active Directory lab check

The following requires the ActiveDirectory PowerShell module, an appropriate domain connection, and sufficient privileges:

```powershell
Get-ADUser -Identity <test-user> -Properties LockedOut,Enabled,PasswordExpired |
    Select-Object SamAccountName,LockedOut,Enabled,PasswordExpired
```

Replace the placeholder with a lab account. The command reads account state; it does not prove the source of repeated failures.

For an authorized lab unlock:

```powershell
Unlock-ADAccount -Identity <test-user>
```

Unlock only after identity verification and investigation. Do not repeatedly unlock an account while ignoring suspicious attempts.

## Resolution and escalation

Address the source of stale credentials through the approved process. Escalate suspicious activity to security and permission changes to the relevant owner. Avoid granting broader access simply to make an error disappear.

## Verification

Confirm normal sign-in and access to the original service. Monitor for recurrence over an appropriate observation period. Record what was verified without publishing usernames or audit logs.

## Suggested lab

Use a disposable test account in an isolated domain with a documented lockout policy. Generate a controlled lockout, inspect status, unlock it, and verify sign-in. Do not test with a production or privileged account.
