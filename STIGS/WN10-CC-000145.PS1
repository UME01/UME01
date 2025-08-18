<#
.SYNOPSIS
    This PowerShell snippet enforces Windows 10 STIG WN10-CC-000145 by requiring a password when the computer wakes from sleep while on battery power. It creates/updates the policy registry key

.NOTES
    Author          : Chiemelie Ume
    LinkedIn        : https://www.linkedin.com/in/chiemelie-ume-a15b45285/
    GitHub          : https://github.com/UME01
    Date Created    : 2025-16-08
    Last Modified   : 2025-16-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000145

.
    syntax:
    PS C:\> .STIG-ID-WN10-AU-000145 
#>

# STIG: WN10-CC-000145
# Require password on wake when on battery

$base = 'HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings'
$guid = '0e796bdb-100d-47d6-a2d5-f7d2daa51f51'   # Sleep: "Require a password when a computer wakes (on battery)"
$path = Join-Path $base $guid

# Create the key and set to Enabled (1)
New-Item -Path $path -Force | Out-Null
New-ItemProperty -Path $path -Name 'DCSettingIndex' -PropertyType DWord -Value 1 -Force | Out-Null

# (Optional) refresh policy cache
gpupdate /target:computer /force | Out-Null

# Verify
(Get-ItemProperty -Path $path -Name 'DCSettingIndex').DCSettingIndex

