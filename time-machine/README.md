### Time Machine

一个基于 Alpine 系统的 netatalk 和 avahi 的用于 Mac Time Machine 备份镜像

### 启动方式

> 由于 avahi 自动发现服务需要绑定网卡接口，所以容器需要使用 host 网络模式启动，
以保证同一局域网下的 Mac 设备能正确发现 TimeMachine 备份容器

- 纯 docker 启动

``` sh
docker run -dt --name time-machine -v /data:/data --network host mritd/time-machine -u testuser -p 12345678
```

- docker-compoe 启动

``` sh
# docker-compose 文件如下
version: '3.5'
services:
  time-machine:
    image: mritd/time-machine
    restart: always
    container_name: time-machine
    network_mode: "host"
    volumes:
      - /data:/data
    command: "-u testuser -p 12345678"

# 最后启动即可
docker-compose up -d
```

### 使用方法

容器启动后在**与宿主机同一局域网**的 Mac 机器能够在 Finder 中的 `共享的` 一栏中发现；
打开后右上角点击链接按钮，然后输入账户和密码即可成功链接；此时打开 TimeMachine 备份磁盘
中选择刚刚建立连接的磁盘即可

### Update

- 2019-07-21: 支持 `-i` 选项定义 user id，升级 netatalk 到 3.1.12
