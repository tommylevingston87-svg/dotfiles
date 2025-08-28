# 1. Import Chocolatey helpers
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
    # Check if the first argument is our special flag '--rg'
    if ($args[0] -eq '--rg') {
        $searchTerm = $args[1]
        
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

            # Open the file in nvim and jump directly to the correct line!
            nvim "+$line" "$file"
        }
    }
    else {
        # --- This is your original code ---
        # If no '--rg' flag, just find directories like before.
        $dir = fd --type d . $HOME | fzf
        if ($null -ne $dir) {
            z $dir
        }
    }
}