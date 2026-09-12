# Legt fuer jeden Skill unter skills/ eine Junction in ~/.claude/skills/<name> an.
# Aufruf: pwsh scripts/link-skills.ps1   (aus dem Repo-Wurzelverzeichnis oder von ueberall)
# Bestehende Junctions auf dieses Repo werden erneuert, fremde Eintraege bleiben unangetastet.

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$skillsDir = Join-Path $repoRoot "skills"
$target = Join-Path $HOME ".claude\skills"

New-Item -ItemType Directory -Force -Path $target | Out-Null

Get-ChildItem -Directory $skillsDir | ForEach-Object {
    $name = $_.Name
    $link = Join-Path $target $name
    if (Test-Path $link) {
        $item = Get-Item $link -Force
        if ($item.LinkType -eq "Junction" -and ($item.Target -join "") -eq $_.FullName) {
            Write-Host "unveraendert  $name"
            return
        }
        if ($item.LinkType -eq "Junction") {
            Remove-Item $link -Force
        } else {
            Write-Warning "$link existiert und ist keine Junction. Uebersprungen."
            return
        }
    }
    New-Item -ItemType Junction -Path $link -Target $_.FullName | Out-Null
    Write-Host "verlinkt      $name -> $($_.FullName)"
}
