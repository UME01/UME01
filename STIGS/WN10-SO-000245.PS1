<#
.SYNOPSIS
   This PowerShell enforces Admin Approval Mode for the built-in Administrator and ensures UAC is enabled. It creates/updates
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System with EnableLUA=1 (turn on UAC) and FilterAdministratorToken=1 (put built-in Administrator into Admin Approval Mode), then verifies both values.
.NOTES
    Author          : Chiemelie Ume
    LinkedIn        : https://www.linkedin.com/in/chiemelie-ume-a15b45285/
    GitHub          : https://github.com/UME01
    Date Created    : 2025-16-08
    Last Modified   : 2025-16-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000245

.
    syntax:
    PS C:\> .STIG-ID-WN10-SO-000245
#>

# STIG: WN10-SO-000245
# UAC: Admin Approval Mode for the built-in Administrator = Enabled

$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'

# Make sure the key exists
New-Item -Path $path -Force | Out-Null

# UAC must be on
New-ItemProperty -Path $path -Name EnableLUA -PropertyType DWord -Value 1 -Force | Out-Null

# Put the built-in Administrator into Admin Approval Mode
New-ItemProperty -Path $path -Name FilterAdministratorToken -PropertyType DWord -Value 1 -Force | Out-Null

# Verify
Get-ItemProperty -Path $path -Name EnableLUA,FilterAdministratorToken |
 Select-Object EnableLUA,FilterAdministratorToken
