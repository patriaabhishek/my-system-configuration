$apps = Get-Content "apps.txt"
foreach (${app} in ${apps}) {
    try {
        winget install ${app} -e  # Use -e for exact match
        Write-Host "${app} installed successfully."
    } catch {
        Write-Host "Failed to install ${app}: ${_}"
    }
}
