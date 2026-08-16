$ErrorActionPreference='Stop'
$root=$PSScriptRoot
$dir=Join-Path $root 'VolKlotski\pictureset'
Write-Host "USING DIR: $dir"
$files=@('jiemian.jpg','finished.jpg','bg.jpg','2.jpg','3.jpg','4.jpg','5.jpg','6.jpg','66.jpg','v1.jpg','v2.jpg','z.jpg')
$out=@{}
foreach($f in $files){
  $path=Join-Path $dir $f
  if(-not (Test-Path -LiteralPath $path)){ Write-Host "MISSING: $path"; continue }
  try{
    $bytes=[System.IO.File]::ReadAllBytes($path)
    $b64=[System.Convert]::ToBase64String($bytes)
    $out[$f]=$b64
    Write-Host ("OK "+$f+" ("+$bytes.Length+" bytes)")
  }catch{
    Write-Host ("ERR "+$f+" "+$_.Exception.Message)
  }
}
$json=$out | ConvertTo-Json -Compress -Depth 2
Set-Content -Path (Join-Path $root 'img_base64_map.json') -Value $json -Encoding UTF8
Write-Host ("DONE: keys="+$out.Count)
