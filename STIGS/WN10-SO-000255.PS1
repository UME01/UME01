.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Chiemelie Ume
    LinkedIn        : https://www.linkedin.com/in/chiemelie-ume-a15b45285/
    GitHub          : https://github.com/UME01
    Date Created    : 2025-16-08
    Last Modified   : 2025-16-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000255

.
    syntax:
    PS C:\> .STIG-ID-WN10-SO-000255 
#>
# STIG: WN10-SO-000255
# UAC: Automatically deny elevation requests for standard users

$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
New-Item -Path $path -Force | Out-Null
New-ItemProperty -Path $path -Name 'ConsentPromptBehaviorUser' -PropertyType DWord -Value 0 -Force | Out-Null

# Verify
(Get-ItemProperty -Path $path -Name 'ConsentPromptBehaviorUser').ConsentPromptBehaviorUser
