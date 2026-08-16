$ErrorActionPreference='Stop'
$root=$PSScriptRoot
$imgDir=Join-Path $root 'VolKlotski\pictureset'
$img66=Join-Path $imgDir '66.jpg'
$imgv2=Join-Path $imgDir 'v2.jpg'
function B64($p){$bytes=[System.IO.File]::ReadAllBytes($p); return 'data:image/jpeg;base64,'+[System.Convert]::ToBase64String($bytes)}
$d66=B64 $img66
$dv2=B64 $imgv2
Write-Host ("66  data len="+$d66.Length)
Write-Host ("v2  data len="+$dv2.Length)
$lines=@"
DATA_66=$d66
DATA_V2=$dv2
"@
Set-Content -Path (Join-Path $root 'fixed_66_v2.txt') -Value $lines -Encoding UTF8
Write-Host 'WROTE fixed_66_v2.txt'
