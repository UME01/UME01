<#
.SYNOPSIS
   This PowerShell enforces the Windows Installer policy “Allow user control over installs” = Disabled by creating/updating
HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer and setting EnableUserControl=0.
.NOTES
    Author          : Chiemelie Ume
    LinkedIn        : https://www.linkedin.com/in/chiemelie-ume-a15b45285/
    GitHub          : https://github.com/UME01
    Date Created    : 2025-17-08
    Last Modified   : 2025-17-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000310

.
    syntax:
    PS C:\> .STIG-ID-WN10-CC-000310 
#>
# Prevent users from changing installation options
$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer'
$name    = 'EnableUserControl'
$value   = 0  # required

# Ensure key exists
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }

# Create or update the value (DWORD)
if (Get-ItemProperty -Path $regPath -Name $name -ErrorAction SilentlyContinue) {
    Set-ItemProperty -Path $regPath -Name $name -Value $value
} else {
    New-ItemProperty -Path $regPath -Name $name -PropertyType DWord -Value $value -Force | Out-Null
}

# Verify
$actual = (Get-ItemProperty -Path $regPath -Name $name).$name
Write-Host "EnableUserControl = $actual (expected 0)"


