<#
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
    STIG-ID         : WN10-AU-000185

.
    syntax:
    PS C:\> .STIG-ID-WN10-AU-000185
#>

# STIG: WN10-CC-000185
# Set "Do not execute any autorun commands"

$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$name = 'NoAutorun'
$value = 1   # 1 = Do not execute any autorun commands (enabled)

# Create the key if it doesn't exist, then set the value
New-Item -Path $path -Force | Out-Null
New-ItemProperty -Path $path -Name $name -PropertyType DWord -Value $value -Force | Out-Null

# (Optional) refresh policy view
gpupdate /target:computer /force | Out-Null

# Verify
(Get-ItemProperty -Path $path -Name $name).$name


