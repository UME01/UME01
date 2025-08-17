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
    STIG-ID         : WN10-AU-000580

.
    syntax:
    PS C:\> .STIG-ID-WN10-AU-000580
#>
# 1) Ensure subcategory auditing takes effect (required prerequisite)
#    "Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings"
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' `
  -Name 'SCENoApplyLegacyAuditPolicy' -PropertyType DWord -Value 1 -Force | Out-Null

# 2) Enable FAILURE auditing for MPSSVC Rule-Level Policy Change
#    (uses auditpol.exe, which is the supported interface for Advanced Audit Policy)
$auditSubcat = 'MPSSVC Rule-Level Policy Change'
Start-Process -FilePath 'auditpol.exe' -ArgumentList "/set /subcategory:`"$auditSubcat`" /failure:enable" -Wait -WindowStyle Hidden

# 3) Verify
auditpol.exe /get /subcategory:"$auditSubcat"
(Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name SCENoApplyLegacyAuditPolicy).SCENoApplyLegacyAuditPolicy
