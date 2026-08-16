$ErrorActionPreference = "Stop"
$picDir = "d:\trae\trae_output\VolKlotski\pictureset"
$htmlPath = "d:\trae\trae_output\VolKlotski\VolKlotski.html"

Write-Host "Reading HTML file..."
$content = [System.IO.File]::ReadAllText($htmlPath)
Write-Host "  HTML size: $($content.Length) chars"

Write-Host "Processing 66.jpg (GUANYU_IMG_AFTER)..."
$b64_66 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("$picDir\66.jpg"))
$guanyuValue = "data:image/jpeg;base64,$b64_66"
Write-Host "  66.jpg base64 length: $($b64_66.Length)"

Write-Host "Processing v2.jpg (CAOCAO_IMG_AFTER)..."
$b64_v2 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("$picDir\v2.jpg"))
$caocaoValue = "data:image/jpeg;base64,$b64_v2"
Write-Host "  v2.jpg base64 length: $($b64_v2.Length)"

Write-Host "Replacing GUANYU_IMG_AFTER..."
$pattern1 = "GUANYU_IMG_AFTER\s*=\s*['\x22][^'\x22]*['\x22]"
$replacement1 = "GUANYU_IMG_AFTER='$guanyuValue'"
$content = [System.Text.RegularExpressions.Regex]::Replace($content, $pattern1, $replacement1)

Write-Host "Replacing CAOCAO_IMG_AFTER..."
$pattern2 = "CAOCAO_IMG_AFTER\s*=\s*['\x22][^'\x22]*['\x22]"
$replacement2 = "CAOCAO_IMG_AFTER='$caocaoValue'"
$content = [System.Text.RegularExpressions.Regex]::Replace($content, $pattern2, $replacement2)

Write-Host "Saving HTML file..."
[System.IO.File]::WriteAllText($htmlPath, $content, [System.Text.UTF8Encoding]::new($false))
Write-Host "Done! Final HTML size: $($content.Length) chars"
