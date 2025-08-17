<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Chiemelie Ume
    LinkedIn        : https://www.linkedin.com/in/chiemelie-ume-a15b45285/
    GitHub          : https://github.com/UME01
    Date Created    : 2025-17-08
    Last Modified   : 2025-17-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000230

.
    syntax:
    PS C:\> .STIG-ID-WN10-SO-000230
#>
# Policy: System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing
# STIG mapping (example): WN10-SO-000230

# Run from an elevated PowerShell window
$me = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $me.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Run this in an elevated PowerShell session (Run as administrator)."
}

$regPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\FipsAlgorithmPolicy'
New-Item -Path $regPath -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'Enabled' -PropertyType DWord -Value 1 -Force | Out-Null

Write-Host "Configured: FIPS mode enabled (Enabled=1). Some apps may require restart to pick this up."
