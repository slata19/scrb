param(
    [string]$SiteUrl,
    [string]$FileServerRelativeUrl,
    [string]$OutputPath,
    [string]$Username,
    [string]$Password
)

$secure = ConvertTo-SecureString $Password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($Username, $secure)

if (-not (Get-Module -ListAvailable -Name "PnP.PowerShell")) {
    Install-Module PnP.PowerShell -Force -Scope CurrentUser
}
Import-Module PnP.PowerShell -ErrorAction Stop

Connect-PnPOnline -Url $SiteUrl -Credentials $cred

New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null

Get-PnPFile -Url $FileServerRelativeUrl `
            -Path $OutputPath `
            -FileName "Workbook.xlsm" `
            -AsFile `
            -Force
