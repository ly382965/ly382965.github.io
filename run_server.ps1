[CmdletBinding()]
param(
    [string]$BindHost = "127.0.0.1",
    [int]$Port = 4000,
    [switch]$Drafts,
    [switch]$Future,
    [switch]$Incremental,
    [switch]$LiveReload,
    [switch]$BuildOnly,
    [switch]$CheckOnly,
    [switch]$InstallDependencies
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

function Exit-IfCommandMissing {
    param(
        [Parameter(Mandatory = $true)]
        [string]$CommandName,
        [Parameter(Mandatory = $true)]
        [string]$InstallHint
    )

    if (-not (Get-Command $CommandName -ErrorAction SilentlyContinue)) {
        Write-Error "$CommandName was not found. $InstallHint"
        exit 1
    }
}

Set-Location $repoRoot

Exit-IfCommandMissing -CommandName "ruby" -InstallHint "Install Ruby first."
Exit-IfCommandMissing -CommandName "bundle" -InstallHint "Install Bundler first, or add it to PATH."

if ($InstallDependencies) {
    Write-Host "Installing gems from Gemfile..." -ForegroundColor Cyan
    & bundle install
    $installExitCode = $LASTEXITCODE
    if ($installExitCode -ne 0) {
        exit $installExitCode
    }
}

# Check dependencies first so the user gets a quick, actionable failure.
& bundle check
$checkExitCode = $LASTEXITCODE
if ($checkExitCode -ne 0) {
    Write-Host ""
    Write-Host "Missing Jekyll dependencies." -ForegroundColor Yellow
    Write-Host "Run one of the following commands and try again:" -ForegroundColor Yellow
    Write-Host "  bundle install" -ForegroundColor Cyan
    Write-Host "  .\run_server.ps1 -InstallDependencies" -ForegroundColor Cyan
    exit $checkExitCode
}

if ($CheckOnly) {
    Write-Host "Environment check passed. You can preview the site locally." -ForegroundColor Green
    exit 0
}

$bundleArgs = @("exec", "jekyll")

if ($BuildOnly) {
    $bundleArgs += "build"
} else {
    $bundleArgs += @("serve", "--host", $BindHost, "--port", $Port)
}

if ($Drafts) {
    $bundleArgs += "--drafts"
}

if ($Future) {
    $bundleArgs += "--future"
}

if ($Incremental) {
    $bundleArgs += "--incremental"
}

if ($LiveReload -and -not $BuildOnly) {
    $bundleArgs += "--livereload"
}

if ($BuildOnly) {
    Write-Host "Building the site into _site ..." -ForegroundColor Cyan
} else {
    Write-Host "Starting local preview at http://$BindHost`:$Port" -ForegroundColor Green
}

& bundle @bundleArgs
$runExitCode = $LASTEXITCODE
exit $runExitCode
