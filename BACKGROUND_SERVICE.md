# Kiro Proxy 后台运行指南

## 方法 1: 使用 nohup（最简单）

### 启动服务
```bash
./start_proxy.sh
```

### 停止服务
```bash
./stop_proxy.sh
```

### 查看日志
```bash
tail -f proxy.log
```

### 查看状态
```bash
cat proxy.pid
ps -p $(cat proxy.pid)
```

---

## 方法 2: 使用 systemd（推荐生产环境）

### 安装服务
```bash
# 复制服务文件
sudo cp kiro-proxy.service /etc/systemd/system/

# 重载 systemd
sudo systemctl daemon-reload

# 启用开机自启
sudo systemctl enable kiro-proxy

# 启动服务
sudo systemctl start kiro-proxy
```

### 管理服务
```bash
# 查看状态
sudo systemctl status kiro-proxy

# 停止服务
sudo systemctl stop kiro-proxy

# 重启服务
sudo systemctl restart kiro-proxy

# 查看日志
sudo journalctl -u kiro-proxy -f

# 或查看文件日志
tail -f /home/keyzj/KiroProxy/proxy.log
```

### 卸载服务
```bash
sudo systemctl stop kiro-proxy
sudo systemctl disable kiro-proxy
sudo rm /etc/systemd/system/kiro-proxy.service
sudo systemctl daemon-reload
```

---

## 方法 3: 使用 screen

### 安装 screen
```bash
sudo apt install screen
```

### 启动服务
```bash
./start_with_screen.sh
```

### 管理会话
```bash
# 查看所有会话
screen -ls

# 连接到会话（查看日志）
screen -r kiro-proxy

# 退出会话（不停止服务）
# 按 Ctrl+A，然后按 D

# 停止服务
screen -S kiro-proxy -X quit
```

---

## 方法 4: 使用 tmux

### 安装 tmux
```bash
sudo apt install tmux
```

### 启动服务
```bash
# 创建新会话并启动
tmux new -d -s kiro-proxy "cd /home/keyzj/KiroProxy && source .venv/bin/activate && python run.py 8081"
```

### 管理会话
```bash
# 查看所有会话
tmux ls

# 连接到会话
tmux attach -t kiro-proxy

# 退出会话（不停止服务）
# 按 Ctrl+B，然后按 D

# 停止服务
tmux kill-session -t kiro-proxy
```

---

## 方法 5: 使用 Docker（最佳隔离）

### 创建 Dockerfile
```dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8081
CMD ["python", "run.py", "8081"]
```

### 构建和运行
```bash
# 构建镜像
docker build -t kiro-proxy .

# 运行容器
docker run -d --name kiro-proxy -p 8081:8081 --restart unless-stopped kiro-proxy

# 查看日志
docker logs -f kiro-proxy

# 停止容器
docker stop kiro-proxy

# 启动容器
docker start kiro-proxy
```

---

## 推荐方案

| 场景 | 推荐方法 | 原因 |
|------|---------|------|
| 快速测试 | nohup | 最简单，无需额外配置 |
| 开发调试 | screen/tmux | 可以随时查看输出 |
| 生产环境 | systemd | 自动重启、开机自启、日志管理 |
| 容器化部署 | Docker | 环境隔离、易于迁移 |

---

## 常见问题

### 如何检查服务是否在运行？
```bash
# 方法 1: 检查端口
netstat -tlnp | grep 8081
# 或
lsof -i :8081

# 方法 2: 检查进程
ps aux | grep "python run.py"

# 方法 3: 测试 API
curl http://localhost:8081/
```

### 如何查看实时日志？
```bash
# nohup 方式
tail -f proxy.log

# systemd 方式
sudo journalctl -u kiro-proxy -f

# screen 方式
screen -r kiro-proxy

# Docker 方式
docker logs -f kiro-proxy
```

### 服务崩溃了怎么办？
```bash
# systemd 会自动重启（如果配置了 Restart=always）

# nohup 方式需要手动重启
./stop_proxy.sh
./start_proxy.sh

# 查看错误日志
tail -100 proxy.log
```

### 如何更新代码后重启服务？
```bash
# 拉取最新代码
git pull

# 安装依赖（如果有更新）
source .venv/bin/activate
pip install -r requirements.txt

# 重启服务
# nohup 方式
./stop_proxy.sh && ./start_proxy.sh

# systemd 方式
sudo systemctl restart kiro-proxy

# screen 方式
screen -S kiro-proxy -X quit
./start_with_screen.sh

# Docker 方式
docker restart kiro-proxy
```
