param(
    [string]$FilePath
)

if (!(Test-Path $FilePath)) {
    throw "Excel file not found at $FilePath"
}

$size = (Get-Item $FilePath).Length
if ($size -lt 50000) {
    throw "File size too small — possible corruption"
}

Add-Type -AssemblyName System.IO.Compression.FileSystem

$zip = [System.IO.Compression.ZipFile]::OpenRead($FilePath)
$vba = $zip.Entries | Where-Object { $_.FullName -like "xl/vbaProject.bin" }
$zip.Dispose()

if (-not $vba) {
    throw "VBA project missing — expected macros not found"
}

Write-Host "Validation passed for $FilePath"
