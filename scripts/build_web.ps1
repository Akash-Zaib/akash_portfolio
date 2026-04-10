# Build for GitHub Pages project site: https://<user>.github.io/<repo>/
# Usage: .\scripts\build_web.ps1
# Optional: .\scripts\build_web.ps1 -RepoName "my-repo"

param(
    [string]$RepoName = "akash_portfolio"
)

$ErrorActionPreference = "Stop"
$baseHref = "/$RepoName/"
Write-Host "Building with --base-href $baseHref" -ForegroundColor Cyan
flutter pub get
flutter build web --release --base-href $baseHref
