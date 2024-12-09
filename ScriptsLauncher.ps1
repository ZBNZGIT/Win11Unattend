$script1Url = "https://raw.githubusercontent.com/ZBNZGIT/AppsInstaller/main/ChocolateyInstallApps.bat"
$script2Url = "https://raw.githubusercontent.com/ZBNZGIT/RemoveEdge/main/RemovesEdge.bat"

function Show-Menu {
    Clear-Host
    Write-Host "1. Install Apps"
    Write-Host "2. Remove Edge" 
    Write-Host "3. Activate Windows (Script will restart, please be patient...)"
    Write-Host "4. Exit"
}

function Run-Script {
    param ([string]$scriptUrl)
    try {
        $scriptContent = Invoke-RestMethod -Uri $scriptUrl
        $tempFile = [System.IO.Path]::GetTempFileName() + ".bat"
        Set-Content -Path $tempFile -Value $scriptContent
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c $tempFile" -WindowStyle Normal
    }
    catch {
        Write-Error "An error occurred: $_"
    }
}

do {
    Show-Menu
    switch (Read-Host "Please select an option (1-4)") {
        '1' { Run-Script -scriptUrl $script1Url; exit }
        '2' { Run-Script -scriptUrl $script2Url; exit }
        '3' { Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/massgravel/get.activated.win/main/get | iex`"" -WindowStyle Hidden; Stop-Process -Id $PID }
        '4' { exit }
        default { Write-Host "Invalid choice, please try again." }
    }
} while ($true)


timeout -t 3 -nobreak > nul
