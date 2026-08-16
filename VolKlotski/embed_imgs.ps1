$ErrorActionPreference='Stop'
$root=$PSScriptRoot
$imgDir=Join-Path $root 'VolKlotski\pictureset'
$htmlPath=Join-Path $root 'VolKlotski.html'
$html=[System.IO.File]::ReadAllText($htmlPath,[System.Text.Encoding]::UTF8)
$files=@('jiemian.jpg','finished.jpg','bg.jpg','2.jpg','3.jpg','4.jpg','5.jpg','6.jpg','66.jpg','v1.jpg','v2.jpg','z.jpg')
$PREFIX='data:image/jpeg;base64,'
foreach($f in $files){
  $path=Join-Path $imgDir $f
  if(-not (Test-Path -LiteralPath $path)){ Write-Host "SKIP missing: $f"; continue }
  $bytes=[System.IO.File]::ReadAllBytes($path)
  $b64=[System.Convert]::ToBase64String($bytes)
  $replacement=$PREFIX+$b64
  # 替换所有出现的裸文件名（大小写不敏感，全局）
  $options=[System.StringComparison]::OrdinalIgnoreCase
  $count=0
  $idx=0
  $sb=New-Object System.Text.StringBuilder (($html.Length + $replacement.Length*2))
  while(($i=$html.IndexOf($f,$idx,$options)) -ge 0){
    [void]$sb.Append($html.Substring($idx,$i-$idx))
    [void]$sb.Append($replacement)
    $idx=$i+$f.Length
    $count++
  }
  [void]$sb.Append($html.Substring($idx))
  $html=$sb.ToString()
  Write-Host ("Replace {0,-12} -> {1} occurrences ({2} bytes source)" -f $f,$count,$bytes.Length)
}
[System.IO.File]::WriteAllText($htmlPath,$html,[System.Text.Encoding]::UTF8)
Write-Host ("DONE wrote "+$htmlPath+" new size="+$html.Length+" chars")
