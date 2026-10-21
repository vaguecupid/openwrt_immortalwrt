# PassWall + Sing-box + Shadowsocks-rust 编译调整与审计

## 实际修改
- `configs/X86.config`: 启用 sing-box、shadowsocks-rust-sslocal 以及 PassWall 对应客户端选项；仍禁用 geoview 和 Shadowsocks-rust 服务端。
- `scripts/diy-part2.sh`: 删除 `feeds uninstall rust` 和清除 `.config` Rust 配置的代码。
- `.github/workflows/X86_64_openwrt.yml`: `make defconfig` 后对客户端软件包和 PassWall 选项进行验证，验证 Rust feed 存在；正式固件构建前单独编译 Shadowsocks-rust 和 Sing-box。

## 重要限制
1. 仅运行 Python/YAML/Shell 静态检查，**没有执行 ImmortalWrt 全量固件编译**；无法保证构建通过。
2. 原项目使用 `immortalwrt/openwrt-24.10` 的滚动源码及 PassWall `main` 分支，工具链版本会漂移。此前 geoview 因 Go 1.25 要求失败，继续保持禁用。Sing-box 同样可能要求更新 Go 版本。
3. `error[E0463] can't find crate core` 可能是 OpenWrt 内部 Rust host 标准库未构建、版本不匹配，不能直接断定只缺 Runner 的 `rustup target`。保留 Rust feed 是必要条件，但不是充分条件。
4. 若 `shadowsocks-rust` 依然报 E0463，应查看编译日志中实际 `rustc` / `cargo` 路径、`--target`、`RUSTFLAGS`、`staging_dir/host` Rust stdlib 文件；必要时锁定适配的 packages/rust 和 PassWall commit，或更新 Rust host 构建链。
5. Release 403 已有 `permissions: contents: write`，仍需 Fork 的 Settings → Actions → General → Workflow permissions 允许写入。
6. 禁用 Geoview 不影响核心代理，但使用 Geoview 的数据转换功能不可用；OpenClash 和 PassWall 不应同时接管透明代理/DNS。

## 编译前必须检查
- `make defconfig` 后包选择完整
- `feeds/packages/lang/rust/Makefile` 存在
- Rust host 实际完成构建，并具有 x86_64-unknown-linux-musl 的 sysroot 标准库
- Sing-box 的 go.mod 所需 Go 版本不高于最终用于编译的 OpenWrt Go host 版本
