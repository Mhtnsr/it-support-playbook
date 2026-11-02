# Runbook 01: Network connectivity

**Type:** Reference guide. No execution results are claimed.

## Triage

Ask whether one application, one device, or multiple users are affected. Record when it began, recent changes, the connection type, and whether a required VPN is connected. Check for a known outage before changing the endpoint.

## Investigation

| Check | Why it matters | Next decision |
| --- | --- | --- |
| Cable, link lights, Wi-Fi association, airplane mode | Establishes basic connectivity | Restore the expected connection before higher-layer tests |
| Adapter status and IP configuration | Identifies missing addressing or an unexpected network | Compare with approved configuration or a working device |
| Default gateway reachability | Tests the local path | Investigate local segment if unavailable; remember ICMP may be blocked |
| Required destination and service port | Tests the actual service path | Distinguish network reachability from service failure |
| DNS resolution | Tests name lookup | Follow the DNS runbook if names fail |
| VPN/proxy requirements | Identifies a missing application path | Compare with the approved configuration |

## Example Windows checks

Run these in PowerShell on an authorized test device:

```powershell
Get-NetAdapter
Get-NetIPConfiguration
ipconfig /all
```

Choose the real gateway and approved service endpoint from the environment:

```powershell
Test-Connection -ComputerName <default-gateway> -Count 4
Test-NetConnection -ComputerName <approved-service-host> -Port 443
```

Angle-bracket values are placeholders; replace them before running. Failed ping alone does not prove a host is down. A successful TCP connection does not prove the application is healthy.

## Resolution approach

Correct the specific observed issue: reconnect a cable, select the approved wireless network, restore the expected VPN session, or escalate an addressing problem. Avoid broad network resets or changing corporate DNS as a first step.

## Verification and escalation

Repeat the user's original task and record the result. Escalate multiple-device failures, infrastructure faults, or problems requiring network configuration changes. Include affected scope, timestamps, adapter state, destination, and sanitized diagnostic results.

## Suggested lab

Compare a working connection with a deliberately disconnected adapter in a disposable lab. Record actual differences and restore the original configuration. Do not perform outage simulations on a production device.
