# Runbook 02: DNS resolution

**Type:** Reference guide. No execution results are claimed.

## Triage

Record the exact hostname and error. Determine whether it is an internal or external service, whether other names resolve, and whether an approved VPN is required.

## Investigation

1. Confirm basic addressing and connectivity using the network runbook.
2. Inspect the configured DNS servers.
3. Query the exact hostname and preserve the response or error.
4. Compare with a known-good device on the same network and VPN.
5. Investigate whether the expected record is absent, stale, or returning an unexpected address.

## Example Windows checks

```powershell
Get-DnsClientServerAddress
Resolve-DnsName -Name <target-hostname>
nslookup <target-hostname>
```

Replace placeholders with an approved target. A DNS lookup failure can reflect connectivity, DNS server availability, search suffix behavior, or a missing record.

Do not send internal hostnames to a public resolver during troubleshooting. A website opened by IP may fail because of TLS certificates or virtual hosting; that result alone does not diagnose DNS.

## Resolution approach

If evidence identifies a stale local cache and a refresh is authorized:

```powershell
Clear-DnsClientCache
```

This clears the local cache; it does not fix an incorrect DNS server record. Escalate missing or incorrect managed records to the DNS owner. Keep the approved resolver configuration intact.

## Verification

Repeat the lookup, compare the answer with the expected record, and test the application using its normal hostname. Record both the DNS result and application behavior.

## Suggested lab

In an isolated DNS lab, compare an existing test record with a deliberately nonexistent name. Save real output and explain the difference between lookup failure and a service connection failure.

