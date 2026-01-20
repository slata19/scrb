param(
    [string]$SiteUrl,
    [string]$LibraryPath,
    [string]$LocalFile,
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

Add-PnPFile -Path $LocalFile -Folder $LibraryPath -Overwrite -ErrorAction Stop

Write-Host "Upload completed to $LibraryPath"
