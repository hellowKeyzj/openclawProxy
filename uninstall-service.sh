#!/bin/bash
# 卸载 Kiro Proxy systemd 服务

set -e

echo "==================================="
echo "卸载 Kiro Proxy systemd 服务"
echo "==================================="

# 检查是否以 root 运行
if [ "$EUID" -ne 0 ]; then 
    echo "错误: 请使用 sudo 运行此脚本"
    echo "用法: sudo ./uninstall-service.sh"
    exit 1
fi

# 停止服务
if systemctl is-active --quiet kiro-proxy; then
    echo "停止服务..."
    systemctl stop kiro-proxy
fi

# 禁用开机自启
if systemctl is-enabled --quiet kiro-proxy; then
    echo "禁用开机自启..."
    systemctl disable kiro-proxy
fi

# 删除服务文件
if [ -f /etc/systemd/system/kiro-proxy.service ]; then
    echo "删除服务文件..."
    rm /etc/systemd/system/kiro-proxy.service
fi

# 重载 systemd
echo "重载 systemd..."
systemctl daemon-reload

echo ""
echo "==================================="
echo "卸载完成！"
echo "==================================="
