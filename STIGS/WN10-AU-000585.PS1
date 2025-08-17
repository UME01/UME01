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
    STIG-ID         : WN10-AU-000585

.
    syntax:
    PS C:\> .STIG-ID-WN10-AU-000585
#>
# ==== STIG WN10-AU-000585 ====
# Requirement: Audit Process Creation = Failure (Advanced Audit Policy)

# Ensure we're elevated
$me = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $me.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Run this in an elevated PowerShell session (Run as administrator)."
}

# Enable FAILURE auditing for Process Creation (does NOT touch Success)
$auditCmd = 'auditpol /set /subcategory:"Process Creation" /failure:enable'
$null = Invoke-Expression $auditCmd

# ---- Optional but commonly paired in STIGs ----
# If your benchmark also requires logging the command line for 4688 events,
# enable: “Include command line in process creation events”
$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit'
New-Item -Path $regPath -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'ProcessCreationIncludeCmdLine_Enabled' -PropertyType DWord -Value 1 -Force | Out-Null

Write-Host "Configured: Audit Process Creation = Failure (and command-line logging enabled)."
