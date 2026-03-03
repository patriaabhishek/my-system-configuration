param(
    [string]$InputFolder = "C:\Users\abhis\Desktop\video-convertor\Videos",
    [string]$OutputFolder = "C:\Users\abhis\Desktop\video-convertor\Videos - Compressed"
)

# Check if input exists
if (-not (Test-Path $InputFolder)) {
    Write-Error "Input folder not found"
    exit 1
}

# Create output folder if missing
if (-not (Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

# Get all MP4 files recursively
Get-ChildItem -Path $InputFolder -Filter *.mp4 -Recurse | ForEach-Object {
    $inputFile = $_.FullName

    # Get relative path to preserve folder structure
    $relativePath = $_.DirectoryName.Substring($InputFolder.Length).TrimStart('\')

    # Build corresponding output directory path
    $outputDir = Join-Path $OutputFolder $relativePath

    # Ensure the output directory exists
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }

    # Define output file path
    $outputFile = Join-Path $outputDir ($_.BaseName + ".mp4")

    Write-Host "Compressing $($_.FullName) -> $outputFile"

    # Run FFmpeg command (GPU accelerated)
    $cmd = "ffmpeg -i `"$inputFile`" -c:v hevc_nvenc -preset slow -cq 28 -c:a aac -b:a 96k `"$outputFile`""
    Invoke-Expression $cmd

    Write-Host "✅ Done -> $outputFile"
}

Write-Host "`nAll videos processed successfully!"