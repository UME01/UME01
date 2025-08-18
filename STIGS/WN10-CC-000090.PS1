
<#
.SYNOPSIS
    This script enforces Windows 10 STIG WN10-CC-000090 by making the Group Policy client reapply registry policy at every refresh, even when no GPO changes are detected. It requires elevation, then creates/updates
HKLM\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2} and sets NoGPOListChanges=0.

.NOTES
    Author          : Chiemelie Ume
    LinkedIn        : https://www.linkedin.com/in/chiemelie-ume-a15b45285/
    GitHub          : https://github.com/UME01
    Date Created    : 2025-17-08
    Last Modified   : 2025-17-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         :  WN10-CC-000090

.
    syntax:
    PS C:\> .STIG-ID WN10-CC-000090
#>

# STIG: WN10-CC-000090
# Path: HKLM\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}
# Value: NoGPOListChanges (DWORD) = 0

# Run in an elevated PowerShell window
$me = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $me.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Run this in an elevated PowerShell session (Run as administrator)."
}

$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}'
New-Item -Path $regPath -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'NoGPOListChanges' -PropertyType DWord -Value 0 -Force | Out-Null

Write-Host "Configured: NoGPOListChanges = 0 (reprocess GPOs even if unchanged)."
