$InstallApps = "https://raw.githubusercontent.com/ZBNZGIT/AppsInstaller/main/ChocolateyInstallApps.bat"
$RemoveEdge = "https://raw.githubusercontent.com/ZBNZGIT/RemoveEdge/main/RemoveEdge.ps1" 
$MASActivation = "https://get.activated.win"

function RunBatchScript {
    param ([string]$scriptUrl)
    try {
        $scriptContent = Invoke-RestMethod -Uri $scriptUrl
        $tempFile = [System.IO.Path]::GetTempFileName() + ".bat"
        Set-Content -Path $tempFile -Value $scriptContent
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c $tempFile" -WindowStyle Normal
    }
    catch {
        $errorMessage = "An error occurred while executing the batch script."
        Write-Host $errorMessage -ForegroundColor Yellow
    }
}

function RunRemoveEdge {
    [CmdletBinding()]
    param()
    try {
        Invoke-RestMethod -Uri $RemoveEdge | Invoke-Expression
    }
    catch {
        Write-Error "An error occurred when running Remove Edge script"
        Write-Host $errorMessage -ForegroundColor Yellow
    }
}

function RunMASActivation {
    [CmdletBinding()]
    param()
    try {
        Invoke-RestMethod -Uri $MASActivation | Invoke-Expression
    }
    catch {
        Write-Error "An error occurred when running MAS Activation script"
        Write-Host $errorMessage -ForegroundColor Yellow
    }
}

function Show-Menu {
Clear-Host
@"
1. Install Apps
2. Remove Edge
3. Activate Windows
4. Exit
"@ | Write-Host
}

do {
    Show-Menu
    $choice = Read-Host "Please select an option (1-4)"
    
    switch ($choice) {
        '1' { RunBatchScript -scriptUrl $InstallApps; exit }
        '2' { RunRemoveEdge; exit }
        '3' { RunMASActivation; exit }
        '4' { exit }
        default { Write-Host "Invalid choice, please try again." -ForegroundColor Red }
    }
    if ($choice -match '[1-3]') { exit }
} while ($true)

Start-Sleep -Seconds 3
