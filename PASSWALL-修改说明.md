# herofence/openwrt_immortalwrt — PassWall 集成修改

基于用户上传的 2026-09-16 仓库源码快照修改；原有 iStore、OpenClash、Docker 等配置保留。

## 修改内容

1. `.github/workflows/X86_64_openwrt.yml`：在“下载源码”阶段向 `feeds.conf.default` **顶部**添加官方 PassWall 两个 feeds，发生于 `./scripts/feeds update -a` 之前；`make defconfig` 后验证 PassWall、Xray 已入选，否则立即失败；发布文案注明 PassWall。
2. `configs/X86.config`：将原来明确禁用 PassWall 的行改为开启 `luci-app-passwall` 和 `xray-core`。默认暂不开启 sing-box，以降低编译风险，按需可启用。
3. 其他源码和配置未作修改。

## 如何用于自己的 Fork

建议在 GitHub 个人 Fork 仓库对应位置分别覆盖上述两个文件，并添加本说明；或在本地使用 git clone 克隆自己 Fork，复制两个文件后 git add、git commit、git push。

在 Fork 的 Actions 页启用工作流，运行 `immortalwrt_x86_64` -> `Run workflow`。之后从 Actions Artifacts / Releases 下载固件。首次构建可能因 upstream feeds 版本、依赖冲突或 runner 环境变化失败，需要查看日志继续排查。

## 注意

- 此 ZIP **不是**完整 ImmortalWrt 操作系统源码；它是用户上传的自动编译仓库全部文件，工作流运行时再克隆 ImmortalWrt 源码。
- 已完成配置静态检查，但并未执行耗时的云端全量固件编译，**不保证首次编译成功**。
- 如需 PassWall2，可另外集成官方 `openwrt-passwall2` feed，并选择 `luci-app-passwall2`；建议先确认 PassWall 正常构建。
- OpenClash 和 PassWall 安装后可以共存，实际使用时避免同时接管同一透明代理和 DNS 流量。
