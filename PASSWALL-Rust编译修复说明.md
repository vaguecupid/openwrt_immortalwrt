# PassWall shadowsocks-rust 构建问题规避方案

错误：`error[E0463]: can't find crate for core`，目标 `x86_64-unknown-linux-musl`。

修改：
1. `configs/X86.config` 关闭可选 `shadowsocks-rust` 及 PassWall 对应客户端/服务端选项，保留 PassWall 和 Xray。
2. `.github/workflows/X86_64_openwrt.yml` 在 `make defconfig` 后检查 `shadowsocks-rust` 没有被重新选择。

注意：这是为当前使用 Xray 的固件提供的编译规避方案，不是完整修复 Rust 工具链。它会使 PassWall 的 Shadowsocks Rust 客户端/服务端不可用；如需这些功能，应修复 OpenWrt 自身使用的 Rust host/target 工具链与相应 musl 目标标准库，不能仅假定 Runner 上运行 `rustup target add` 就能解决。

未运行完整 GitHub Actions 编译。
