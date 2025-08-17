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
    STIG-ID         : WN10-CC-000052

.
    syntax:
    PS C:\> .STIG-ID-WN10-CC-000052
#>

# Path to the policy key
$path = 'HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002'

# Ensure the key exists
New-Item -Path $path -Force | Out-Null

# Set the ECC curve order (REG_MULTI_SZ)
$curves = @('NistP384','NistP256')
New-ItemProperty -Path $path -Name 'EccCurves' -PropertyType MultiString -Value $curves -Force | Out-Null

# Verify
(Get-ItemProperty -Path $path -Name 'EccCurves').EccCurves

