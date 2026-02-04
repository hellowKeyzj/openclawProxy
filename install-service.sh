#!/bin/bash
# 安装 Kiro Proxy systemd 服务

set -e

echo "==================================="
echo "安装 Kiro Proxy systemd 服务"
echo "==================================="

# 检查是否以 root 运行
if [ "$EUID" -ne 0 ]; then 
    echo "错误: 请使用 sudo 运行此脚本"
    echo "用法: sudo ./install-service.sh"
    exit 1
fi

# 停止现有服务（如果存在）
if systemctl is-active --quiet kiro-proxy; then
    echo "停止现有服务..."
    systemctl stop kiro-proxy
fi

# 复制服务文件
echo "复制服务文件到 /etc/systemd/system/..."
cp kiro-proxy.service /etc/systemd/system/

# 重载 systemd
echo "重载 systemd..."
systemctl daemon-reload

# 启用开机自启
echo "启用开机自启..."
systemctl enable kiro-proxy

# 启动服务
echo "启动服务..."
systemctl start kiro-proxy

# 等待服务启动
sleep 2

# 检查状态
echo ""
echo "==================================="
echo "服务状态:"
echo "==================================="
systemctl status kiro-proxy --no-pager

echo ""
echo "==================================="
echo "安装完成！"
echo "==================================="
echo ""
echo "常用命令:"
echo "  查看状态: sudo systemctl status kiro-proxy"
echo "  查看日志: sudo journalctl -u kiro-proxy -f"
echo "  重启服务: sudo systemctl restart kiro-proxy"
echo "  停止服务: sudo systemctl stop kiro-proxy"
echo "  启动服务: sudo systemctl start kiro-proxy"
echo ""
echo "日志文件:"
echo "  标准输出: logs/proxy.log"
echo "  错误输出: logs/proxy-error.log"
echo ""
