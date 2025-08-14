<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Chiemelie Ume
    LinkedIn        : https://www.linkedin.com/in/chiemelie-ume-a15b45285/
    GitHub          : https://github.com/UME01
    Date Created    : 2025-14-08
    Last Modified   : 2025-14-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.
    syntax:
    PS C:\> .STIG-ID-WN10-AU-000500 
#>



# Define the registry path and value
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$ValueName = "MaxSize"
$ValueData = 0x00008000  # Hexadecimal value from your .reg file

# Ensure the registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the DWORD value
Set-ItemProperty -Path $RegPath -Name $ValueName -Value $ValueData -Type DWord

# Confirm change
$CurrentValue = Get-ItemProperty -Path $RegPath -Name $ValueName
Write-Host "Registry value set: $ValueName = $($CurrentValue.$ValueName)"
