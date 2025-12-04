# Lê a chave do .env
$env:GOOGLE_MAPS_API_KEY = (Get-Content .env | Select-String 'GOOGLE_MAPS_API_KEY' | ForEach-Object { $_.ToString().Split('=')[1] })

# Substitui placeholder no template
(Get-Content web\index.template.html) -replace "__GOOGLE_MAPS_API_KEY__", $env:GOOGLE_MAPS_API_KEY | Set-Content web\index.html
