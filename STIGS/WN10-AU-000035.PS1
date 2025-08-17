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
    STIG-ID         : WN10-AU-000035.PS1

.
    syntax:
    PS C:\> .STIG-ID-WN10-AU-000035.PS1
#>
# 1) Ensure subcategory auditing takes effect
#    ("Audit: Force audit policy subcategory settings ... to override ...")
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' `
  -Name SCENoApplyLegacyAuditPolicy -PropertyType DWord -Value 1 -Force | Out-Null

# 2) Enable FAILURE auditing for User Account Management
$auditSubcat = 'User Account Management'
Start-Process -FilePath 'auditpol.exe' `
  -ArgumentList "/set /subcategory:`"$auditSubcat`" /failure:enable" `
  -Wait -WindowStyle Hidden

# 3) Verify
auditpol.exe /get /subcategory:"$auditSubcat"
(Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa').SCENoApplyLegacyAuditPolicy
