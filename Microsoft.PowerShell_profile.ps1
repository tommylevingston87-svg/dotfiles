Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1


# 2. Initialize Oh My Posh for the prompt
oh-my-posh init pwsh --config 'microverse-power' | Invoke-Expression


# 3. Set your preferred editing mode
Set-PSReadlineOption -EditMode Vi


# 4. Initialize zoxide + z to cd swapfunction
Invoke-Expression (& { (zoxide init powershell | Out-String) })
function cd {
    _zoxide_z @args
}
#fd tab auto comp unix behaviour
. "$HOME\Documents\PowerShell\Scripts\fd_completions.ps1"
Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete


function f {
    # --- 1. Ripgrep Content Search (Your Correct Version) ---
    if ($args.Count -gt 0 -and $args[0] -eq '--rg') {
        if ($args.Length -lt 2) { Write-Host "Error: Please provide a search term after '--rg'."; return }
        $searchTerm = $args[1..($args.Count-1)] -join ' '
        
        # Use ripgrep and pipe it to fzf, just like before.
        $selection = rg --line-number --no-heading $searchTerm $HOME | fzf

        # If a selection was made...
        if ($null -ne $selection) {
            # The selection looks like: "C:\path\to\file.py:1:HELLO MAM"
            # We need to cleverly extract the file path and the line number.
            # This regex finds the file path (group 1) and line number (group 2).
            $selection -match '^(.*?):(\d+):' | Out-Null
            $file = $matches[1]
            $line = $matches[2]

            # Open the file in VS code and jump directly to the correct line!
            code --goto "$file`:$line"
        }
    }
    elseif ($args.Count -gt 0 -and $args[0] -eq '--git') {
        # Find all .git directories, get their parent folder, and show in fzf
        $dir = fd --type d --hidden --glob ".git" $HOME | ForEach-Object { Split-Path -Parent $_ } | fzf
        if ($null -ne $dir) {
            z $dir
              }
    }

     # --- 3. NEW: Command History Search ---
    elseif ($args.Count -gt 0 -and $args[0] -eq '--hist') {
        $command = Get-History | Select-Object -ExpandProperty CommandLine | fzf
        if ($null -ne $command) {
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
        }
    }

    #Directory search
    else {
        # --- This is your original code ---
        # If no '--rg' flag, just find directories like before.
        $dir = fd --type d . $HOME | fzf
        if ($null -ne $dir) {
            z $dir
        }
    }
}

function f-s {
    # Use fd to find all files ending in .mp3 or .flac, starting from the Music folder (change path as needed)
    $song = fd --type file -e mp3 -e flac -e m4a . "C:\Users\Owner\Music\My Music" | fzf #--preview="tree /F (Split-Path -Parent {})" --preview-window=right:40%

    # If you select a song from the menu...
    if ($null -ne $song) {
        # Launch the selected file in VLC
        vlc  -I dummy "$song"
    }
}
#Kill vlc 
function stop-vlc {
    taskkill /IM vlc.exe /F | tte matrix
}