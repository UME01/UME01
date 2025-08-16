<#
.SYNOPSIS
    This PowerShell code configures the Windows Account Lockout Duration security policy to comply with the STIG requirement (WN10-AC-000005).

.NOTES
    Author          : Chiemelie Ume
    LinkedIn        : https://www.linkedin.com/in/chiemelie-ume-a15b45285/
    GitHub          : https://github.com/UME01
    Date Created    : 2025-16-08
    Last Modified   : 2025-16-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.
    syntax:
    PS C:\> .STIG-ID-WN10-AU-000005 
#>

# Set lockout duration to 15 minutes (or higher)
$minutes = 15
cmd /c "net accounts /lockoutduration:$minutes"

# (Optional) If you also want the policy to actually lock out on bad attempts:
# cmd /c "net accounts /lockoutthreshold:5"
# cmd /c "net accounts /lockoutwindow:$minutes"
