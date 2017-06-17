## Mattermost

[![](https://images.microbadger.com/badges/image/mritd/mattermost.svg)](https://microbadger.com/images/mritd/mattermost "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/mritd/mattermost.svg)](https://microbadger.com/images/mritd/mattermost "Get your own version badge on microbadger.com")

> Mattermost 是一个开源 IM 工具，目前个人主要应用于自动化部署，如通过 Hubot 对接 Kuberntes 实现机器人部署、GitLab-CI 部署通知、Sentry 错误告警推送等

本镜像基于 Alpine 制作，未集成数据库等，启动测试 docker-compose 如下

``` sh
version: '2'
services:
  mattermost:
    image: mritd/mattermost:3.10.0
    restart: always
    volumes:
      - ./etc/mattermost/config.json:/usr/local/mattermost/config/config.json
    links:
      - mysql
    ports:
      - 8065:8065
  mysql:
    image: mysql:5.7.17
    restart: always
    volumes:
      - ./data/mysql:/var/lib/mysql
      - ./init/init.sql:/docker-entrypoint-initdb.d/init.sql
    environment:
      - MYSQL_ROOT_PASSWORD
```

**完整 docker-compose 配置请参考 [mritd/docker-compose](https://github.com/mritd/docker-compose/tree/master/mattermost)**

