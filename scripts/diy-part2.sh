#!/bin/bash
# 配置修改

# 0. 保留 feeds/packages/lang/rust：Shadowsocks-rust 需要 rust/host。
# 不要卸载 rust，也不要强行删除 .config 中的 Rust 相关选项。
echo "保留 OpenWrt Rust host 构建依赖"

# 1. 修改默认主题
sed -i 's/luci-theme-design/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 2. 修改 feeds 中的时间格式
find feeds/luci/ -path "*/system.lua" -exec sed -i 's/os.date("%c")/os.date("%Y-%m-%d %H:%M:%S")/g' {} \; 2>/dev/null

# 3. 修改默认IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改主机名字
# sed -i s/OpenWrt/herofence/g package/base-files/files/bin/config_generate
