

#Themes
$env:RICH_THEME = "gruvbox-dark"
oh-my-posh init pwsh --config 'gruvbox' | Invoke-Expression
# 1. Import Modules
#Import-Module -Name Az.Tools.Predictor
#Import-Module -Name CompletionPredictor
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Import-Module Terminal-Icons
Set-TerminalIconsTheme -ColorTheme devblackops_light
Set-TerminalIconsTheme -IconTheme devblackops

#2. CD to scripts
cd C:\Users\Owner\Documents\PowerShell
# 3. PS-ReadLine
Set-PSReadLineOption -Colors @{
	     "Parameter" = "Blue"
	         "Command"   = "Green"
	            "Number" = "Cyan"
	               "Operator" = "Magenta"
	                  "Default" = "DarkGreen" 
	                     "ContinuationPrompt" = 'Yellow'
}
Set-PSReadLineOption -Colors @{ Error = 'Red' }
Set-PSReadLineOption -Colors @{ ListPredictionSelected = $PSStyle.Background.Green }
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadlineOption -EditMode Vi
Set-PSReadLineOption -EditMode Vi -ViModeIndicator Cursor
Set-PSReadLineOption -PredictionSource History#AndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
. "$HOME\Documents\PowerShell\Scripts\fd_completions.ps1"
#Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord Ctrl+w -Function BackwardKillWord
#Set-PSReadLineOption -MaximumHistoryCount 10000



# 4. Set zoxide+ z to cd swapfunction
Invoke-Expression (& { (zoxide init powershell | Out-String) })
function cd {
    _zoxide_z @args
}



function f {
    # --- 1. Ripgrep Content Search ---
    if ($args.Count -gt 0 -and $args[0] -eq '--rg') {
        if ($args.Length -lt 2) { Write-Host "Error: Please provide a search term after '--rg'."; return }
        $searchTerm = $args[1..($args.Count-1)] -join ' '
        # Searches within $HOME directory
        $selection = rg --line-number --no-heading $searchTerm $HOME | fzf
        if ($null -ne $selection) {
            $selection -match '^(.*?):(\d+):' | Out-Null
            $file = $matches[1]
            $line = $matches[2]
            code --goto "$file`:$line"
        }
    }
    # --- 2. Git Repository Search (Syntax Fixed) ---
    elseif ($args.Count -gt 0 -and $args[0] -eq '--git') {
        # Searches within your fast $HOME directory
        $dir = fd --type d --hidden --glob ".git" $HOME | ForEach-Object { Split-Path -Parent $_ } | fzf
        if ($null -ne $dir) {
            z $dir
        }
    }
    # --- 3. Command History Search ---
    elseif ($args.Count -gt 0 -and $args[0] -eq '--hist') {
        $command = Get-History | Select-Object -ExpandProperty CommandLine | fzf
        if ($null -ne $command) {
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
        }
    }
    # --- 4. Default Directory Search (Logic Fixed) ---
    elseif ($args.Count -eq 0) {
        # Searches within $HOME directory
        $dir = fd --type d . $HOME | fzf
        if ($null -ne $dir) {
            z $dir
        }
    }
    # --- 5. Catch-all for Invalid Commands (Logic Fixed) ---
    else {
        Write-Host "Error: Command not recognized. Valid flags are --rg, --git, --hist." 
    }
}

function f-song {
    # Use fd to find all audio files in your specified Music folder
    $song = fd --type file -e mp3 -e flac -e m4a . "C:\Users\Owner\Music\My Music" | fzf

    # If you select a song from the menu...
    if ($null -ne $song) {
        # Launch the selected file in VLC (headless)
        vlc -I dummy "$song"
    }
}

#Kill vlc 
function stop-vlc {
    taskkill /IM vlc.exe /F | tte laseretch
}
