# 在本地预览本站 (GitHub Pages)

此仓库使用 Jekyll。为便于在 Windows (PowerShell) 下本地预览，仓库根目录包含 `start-local.ps1` 脚本。

使用方法：在仓库根目录打开 PowerShell，然后运行：

    .\start-local.ps1

脚本逻辑（默认不使用 Docker）：

- 若检测到 `bundle` 且存在 `Gemfile`，脚本运行：`bundle exec jekyll serve -H 127.0.0.1 -P 4000 --livereload`。

- 若未检测到 Bundler/Ruby，脚本会给出安装提示，并以退出码 1 结束。

- 如确需使用 Docker 回退，可显式传参 `-UseDockerFallback`（需预装 Docker）。

脚本会尝试自动在浏览器打开 `http://localhost:4000`。

准备事项（无需 Docker）：

- 安装 Ruby（Windows 推荐 RubyInstaller），完成后重新打开 PowerShell。

- 安装 Bundler，并在仓库根目录安装依赖：

    gem install bundler
    bundle install

常见问题：

- 如果端口被占用，可用 `-Port` 参数指定其他端口，例如：

    .\start-local.ps1 -Port 4001

- 若想监听所有接口（例如在局域网中访问），传入 `-Host '0.0.0.0'`。

示例（非 Docker）：

    .\start-local.ps1 -Port 4001 -Host '0.0.0.0'

可选：启用 Docker 回退（不推荐，除非本机无法安装 Ruby）：

    .\start-local.ps1 -UseDockerFallback

## 终端中文输出乱码怎么办？

脚本已在运行时强制将 PowerShell 会话与子进程切换到 UTF-8。如果仍出现乱码，可在运行前手动执行：

    chcp 65001
    [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
    [Console]::InputEncoding  = New-Object System.Text.UTF8Encoding($false)
    $env:LANG   = 'zh_CN.UTF-8'
    $env:LC_ALL = 'zh_CN.UTF-8'
    $env:RUBYOPT = '-E UTF-8:UTF-8'

然后再启动脚本：

    .\start-local.ps1
