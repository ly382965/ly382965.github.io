param(
    [int]$Port = 4000,
    [string]$Address = '127.0.0.1'
)

# UTF-8 设置
try { chcp 65001 | Out-Null } catch {}
try { [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false) } catch {}

Write-Host "本地预览脚本启动: 端口=$Port 地址=$Address"

$rubyOk = $false
try { ruby --version | Out-Null; if ($LASTEXITCODE -eq 0) { $rubyOk = $true } } catch {}

$bundlerOk = $false
if (Test-Path "Gemfile") {
    try { bundle --version | Out-Null; if ($LASTEXITCODE -eq 0) { $bundlerOk = $true } } catch {}
}

if ($bundlerOk) {
    Write-Host "检测到 Bundler，启动 Jekyll..."
    Start-Sleep -Seconds 1
    try { Start-Process "http://localhost:$Port" } catch {}
    bundle exec jekyll serve -H $Address -P $Port --livereload
} else {
    Write-Warning "未检测到可用的 Ruby/Bundler 环境"
    if (-not $rubyOk) {
        Write-Host "请先安装 Ruby: https://rubyinstaller.org/" -ForegroundColor Yellow
    } else {
        Write-Host "请运行: gem install bundler && bundle install" -ForegroundColor Yellow
    }
    exit 1
}
