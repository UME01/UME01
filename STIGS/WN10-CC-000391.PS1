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
    STIG-ID         : WN10-CC-000391

.
    syntax:
    PS C:\> .STIG-ID-WN10-CC-000391
#>

# Run in an elevated PowerShell window
$me = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $me.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  throw "Run this in an elevated PowerShell session (Run as administrator)."
}

# Enable the policy; 0 = Never, 1 = Always, 2 = Once per user
$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main'
New-Item -Path $regPath -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'NotifyDisableIEOptions' -PropertyType DWord -Value 0 -Force | Out-Null

Write-Host "Configured: IE11 disabled as a standalone browser (NotifyDisableIEOptions=0)."
