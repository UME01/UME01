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
    STIG-ID         : WN10-SO-000005

.
    syntax:
    PS C:\> .STIG-ID-WN10-SO-000005 
#>
# Disable the built-in Administrator (RID 500) without Get-LocalUser
# Works in Windows PowerShell 2.0+ using WMI/ADSI

# Must be elevated
$me = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $me.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Run this in an elevated PowerShell session."
}

function Get-RID500Name {
    try {
        # Try CIM first (newer)
        ($cim = Get-CimInstance Win32_UserAccount -Filter "LocalAccount=true AND SID LIKE '%-500'") | Out-Null
        if ($cim) { return $cim.Name }
    } catch { }
    try {
        # Fallback for older PS
        ($wmi = Get-WmiObject Win32_UserAccount -Filter "LocalAccount=true AND SID LIKE '%-500'") | Out-Null
        if ($wmi) { return $wmi.Name }
    } catch { }
    return $null
}

$name = Get-RID500Name
if (-not $name) { throw "Built-in Administrator (RID 500) was not found on this system." }

# Disable via ADSI (WinNT provider)
$user = [ADSI]"WinNT://$env:COMPUTERNAME/$name,user"
if (-not $user) { throw "Could not bind to local account '$name'." }

if ($user.AccountDisabled -ne $true) {
    $user.AccountDisabled = $true
    $user.SetInfo()
    Write-Host "Disabled built-in Administrator account '$name'."
} else {
    Write-Host "Built-in Administrator account '$name' is already disabled."
}
