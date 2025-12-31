# Arma 3 Headless Client launcher (HC-only)
# AMP foreground process – DO NOT background or loop

$ErrorActionPreference = "Stop"

# Read environment variables injected by AMP
$ServerIP   = $env:HC_SERVER_IP
$ServerPort = $env:HC_SERVER_PORT
$ClientMods = $env:CLIENT_MODS
$CDLC       = $env:CDLC
$ExtraArgs  = $env:HC_EXTRA_ARGS

# Sanity checks (fail fast, fail loud)
if ([string]::IsNullOrWhiteSpace($ServerIP)) {
    Write-Error "HC_SERVER_IP is not set"
}

if ([string]::IsNullOrWhiteSpace($ServerPort)) {
    Write-Error "HC_SERVER_PORT is not set"
}

# Move to Arma directory
Set-Location "arma3hc\233780"

# Build argument list
$Args = @(
    "-client"
    "-connect=$ServerIP"
    "-port=$ServerPort"
)

if (![string]::IsNullOrWhiteSpace($ClientMods)) {
    $Args += "-mod=$ClientMods"
}

if (![string]::IsNullOrWhiteSpace($CDLC)) {
    $Args += "-cdlc=$CDLC"
}

if (![string]::IsNullOrWhiteSpace($ExtraArgs)) {
    $Args += $ExtraArgs
}

# Log what we are doing (AMP console visibility)
Write-Host "Starting Arma 3 Headless Client"
Write-Host "Executable: arma3server_x64.exe"
Write-Host "Arguments : $($Args -join ' ')"

# Launch HC in foreground
# -Wait is CRITICAL so AMP owns the lifecycle
Start-Process `
    -FilePath ".\arma3server_x64.exe" `
    -ArgumentList $Args `
    -Wait `
    -NoNewWindow
