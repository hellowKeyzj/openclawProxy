# 手动安装 Kiro Proxy systemd 服务

## 步骤 1: 安装服务

在终端中执行：

```bash
cd /home/keyzj/KiroProxy
sudo ./install-service.sh
```

输入你的密码后，脚本会自动完成安装。

## 步骤 2: 验证服务状态

```bash
sudo systemctl status kiro-proxy
```

你应该看到类似这样的输出：
```
● kiro-proxy.service - Kiro API Proxy Server
     Loaded: loaded (/etc/systemd/system/kiro-proxy.service; enabled; vendor preset: enabled)
     Active: active (running) since ...
```

## 步骤 3: 测试 API

```bash
curl http://localhost:8081/
```

应该返回：
```json
{"status":"ok","message":"Kiro API Proxy"}
```

## 步骤 4: 测试 tool calling

```bash
curl -X POST http://localhost:8081/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d @test-tool.json
```

应该返回包含 `tool_calls` 的响应。

## 完成！

服务现在会：
- ✅ 在后台运行
- ✅ 开机自动启动
- ✅ 崩溃后自动重启（10秒后）
- ✅ 日志记录到 `logs/` 目录

## 常用命令速查

```bash
# 查看状态
sudo systemctl status kiro-proxy

# 查看日志
sudo journalctl -u kiro-proxy -f

# 重启服务
sudo systemctl restart kiro-proxy

# 停止服务
sudo systemctl stop kiro-proxy

# 启动服务
sudo systemctl start kiro-proxy
```
