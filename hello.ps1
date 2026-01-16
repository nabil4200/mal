# Prints greeting, creates a timestamped file in the user's Downloads folder
Write-Host "Hello"

# Get current timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Determine Downloads folder (Windows: $env:USERPROFILE\Downloads, others: $HOME/Downloads)
if ($env:USERPROFILE) {
    $downloads = Join-Path $env:USERPROFILE 'Downloads'
} elseif ($HOME) {
    $downloads = Join-Path $HOME 'Downloads'
} else {
    # fallback to current directory if neither env var exists
    $downloads = Get-Location
}

# Ensure Downloads folder exists
if (-not (Test-Path $downloads)) {
    New-Item -ItemType Directory -Path $downloads -Force | Out-Null
}

# Create a timestamped filename to avoid overwriting
$filename = "run_$((Get-Date).ToString('yyyyMMdd_HHmmss')).txt"
$fullpath = Join-Path $downloads $filename

# Content to write
$content = "i am runned at $timestamp"

# Write the file (UTF8)
Set-Content -Path $fullpath -Value $content -Encoding UTF8

Write-Host "Created file: $fullpath"
Write-Host "File content:`n$content"

# Pause / wait for user input (cross-platform)
if ($IsWindows) {
    pause
} else {
    Write-Host "Press Enter to continue..."
    Read-Host > $null
}
