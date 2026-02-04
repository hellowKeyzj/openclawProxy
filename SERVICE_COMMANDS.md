# Kiro Proxy systemd 服务管理

## 安装服务

```bash
sudo ./install-service.sh
```

## 管理命令

### 查看状态
```bash
sudo systemctl status kiro-proxy
```

### 启动服务
```bash
sudo systemctl start kiro-proxy
```

### 停止服务
```bash
sudo systemctl stop kiro-proxy
```

### 重启服务
```bash
sudo systemctl restart kiro-proxy
```

### 查看实时日志
```bash
# 查看 systemd 日志
sudo journalctl -u kiro-proxy -f

# 或查看文件日志
tail -f logs/proxy.log
tail -f logs/proxy-error.log
```

### 查看最近日志
```bash
# 最近 100 行
sudo journalctl -u kiro-proxy -n 100

# 今天的日志
sudo journalctl -u kiro-proxy --since today
```

## 卸载服务

```bash
sudo ./uninstall-service.sh
```

## 测试服务

```bash
# 检查端口是否监听
netstat -tlnp | grep 8081

# 测试 API
curl http://localhost:8081/

# 测试 tool calling
curl -X POST http://localhost:8081/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d @test-tool.json
```

## 故障排查

### 服务无法启动
```bash
# 查看详细错误
sudo journalctl -u kiro-proxy -n 50 --no-pager

# 检查配置文件
sudo systemctl cat kiro-proxy

# 手动测试启动
cd /home/keyzj/KiroProxy
source .venv/bin/activate
python run.py 8081
```

### 服务频繁重启
```bash
# 查看重启历史
sudo systemctl status kiro-proxy

# 查看错误日志
tail -100 logs/proxy-error.log
```

### 更新代码后重启
```bash
# 拉取代码
git pull

# 安装依赖（如果有更新）
source .venv/bin/activate
pip install -r requirements.txt

# 重启服务
sudo systemctl restart kiro-proxy

# 查看启动日志
sudo journalctl -u kiro-proxy -f
```
