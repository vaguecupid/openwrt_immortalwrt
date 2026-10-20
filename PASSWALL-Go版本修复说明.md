# PassWall / Geoview Go 版本编译修复

问题：`geoview-0.2.8` 需要 Go >= 1.25，而 ImmortalWrt 24.10 构建使用 Go 1.23.12（`GOTOOLCHAIN=local`）。

## 改动

- `configs/X86.config`：关闭 PassWall 可选 Geoview（`CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Geoview`），保留 PassWall + Xray。
- `.github/workflows/X86_64_openwrt.yml`：`make defconfig` 后检查 Geoview 未被选中；配置 `permissions: contents: write` 允许 Release 创建；整理和发版仅在编译成功后运行。

## 如何使用

将以上两个文件复制覆盖你 Fork 仓库的同名路径并提交，然后 Actions -> immortalwrt_x86_64 -> Run workflow。
如果 `make defconfig` 后仍选中 Geoview，工作流会主动报错并提示排查，不会再次进入漫长的编译阶段。

## 注意

- 本次修复只是避开 Geoview；若其它 Go 软件包也升级了 Go 版本要求，可能出现新的编译错误，需单独定位。
- Github Release 403 还可能因为仓库 Actions 设置将工作流权限设为只读，或者组织策略限制；请检查 Settings -> Actions -> General -> Workflow permissions，并确认允许写权限。
- 未在 GitHub Actions 真实构建验证。
- Geoview 功能不在固件内，但 PassWall 和 Xray 仍会被编译；如果你必须使用 Geoview，需对 ImmortalWrt 构建系统的 Go 工具链做独立升级或使用兼容版本。
