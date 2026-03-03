# Creates dotfile symlinks on Windows (equivalent to `stow` on Linux).
# Requires -RunAsAdministrator

$dotfiles = $PSScriptRoot

$links = @(
    # Windows specific
    @{ src = "$dotfiles\src\powershell\.config\powershell\config.ps1"; dst = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" }
    @{ src = "$dotfiles\src\powershell\.config\powershell\config.ps1"; dst = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" }

    # linux / Windows
    @{ src = "$dotfiles\src\alacritty\.config\alacritty\alacritty.toml"; dst = "$env:APPDATA\alacritty\alacritty.toml" }
    @{ src = "$dotfiles\src\code\.config\Code\User\settings.json";       dst = "$env:APPDATA\Code\User\settings.json" }
    @{ src = "$dotfiles\src\nvim\.config\nvim";                          dst = "$env:LOCALAPPDATA\nvim" }
    @{ src = "$dotfiles\src\git\.config\git\config";                     dst = "$HOME\.gitconfig" }
    @{ src = "$dotfiles\src\yazi\.config\yazi\yazi.toml";                dst = "$env:APPDATA\yazi\config\yazi.toml" }
    @{ src = "$dotfiles\src\zed\.config\zed\settings.json";              dst = "$env:APPDATA\Zed\settings.json" }
    @{ src = "$dotfiles\test_coco.json";              dst = "$HOME\test_coco.json" }
)

Write-Host "Creating Windows configuration symlinks..."
Write-Host " - APPDATA:      $env:APPDATA"
Write-Host " - LOCALAPPDATA: $env:LOCALAPPDATA"
Write-Host " - HOME:         $HOME"
Write-Host " - Dotfiles:     $dotfiles"
Write-Host ""

foreach ($link in $links) {
    $src = $link.src
    $dst = $link.dst

    # Write-Host "[SYMLINK] SRC: $src // DST: $dst"

    if (-not (Test-Path $src)) {
        Write-Host "[ERR] Source not found: $src" -ForegroundColor Red
        continue
    }

    if (Test-Path $dst -ErrorAction SilentlyContinue) {
        $existing = Get-Item $dst -Force
        if ($existing.LinkType -eq 'SymbolicLink') {
            Write-Host "[OK] Already linked: $dst" -ForegroundColor Green
        } else {
            Write-Host "[WARN] Exists but is not a symlink: $dst" -ForegroundColor Yellow
        }
        continue
    }

    $parent = Split-Path $dst -Parent
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    try {
        New-Item -ItemType SymbolicLink -Path $dst -Target $src -ErrorAction Stop | Out-Null
        Write-Host "[CREATED] $dst" -ForegroundColor Cyan
    } catch {
        Write-Host "[ERR] Failed: $_" -ForegroundColor Red
    }
}
