## shadowsocks

[![](https://images.microbadger.com/badges/image/mritd/shadowsocks.svg)](https://microbadger.com/images/mritd/shadowsocks "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/mritd/shadowsocks.svg)](https://microbadger.com/images/mritd/shadowsocks "Get your own version badge on microbadger.com")

- **shadowsocks-libev 版本: 3.1.3**
- **kcptun 版本: 20171201**

### 打开姿势

``` sh
docker run -dt --name ss -p 6443:6443 mritd/shadowsocks -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k test123 --fast-open"
```

### 支持选项

- `-m` : 指定 shadowsocks 命令，默认为 `ss-server`
- `-s` : shadowsocks-libev 参数字符串
- `-x` : 开启 kcptun 支持
- `-e` : 指定 kcptun 命令，默认为 `kcpserver` 
- `-k` : kcptun 参数字符串

### 选项描述

- `-m` : 参数后指定一个 shadowsocks 命令，如 ss-local，不写默认为 ss-server；该参数用于 shadowsocks 在客户端和服务端工作模式间切换，可选项如下: `ss-local`、`ss-manager`、`ss-nat`、`ss-redir`、`ss-server`、`ss-tunnel`
- `-s` : 参数后指定一个 shadowsocks-libev 的参数字符串，所有参数将被拼接到 `ss-server` 后
- `-x` : 指定该参数后才会开启 kcptun 支持，否则将默认禁用 kcptun
- `-e` : 参数后指定一个 kcptun 命令，如 kcpclient，不写默认为 kcpserver；该参数用于 kcptun 在客户端和服务端工作模式间切换，可选项如下: `kcpserver`、`kcpclient`
- `-k` : 参数后指定一个 kcptun 的参数字符串，所有参数将被拼接到 `kcptun` 后

### 命令示例

**Server 端**

``` sh
docker run -dt --name ssserver -p 6443:6443 -p 6500:6500/udp mritd/shadowsocks -m "ss-server" -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k test123 --fast-open" -x -e "kcpserver" -k "-t 127.0.0.1:6443 -l :6500 -mode fast2"
```

**以上命令相当于执行了**

``` sh
ss-server -s 0.0.0.0 -p 6443 -m aes-256-cfb -k test123 --fast-open
kcpserver -t 127.0.0.1:6443 -l :6500 -mode fast2
```

**Client 端**

``` sh
docker run -dt --name ssclient -p 1080:1080 mritd/shadowsocks -m "ss-local" -s "-s 127.0.0.1 -p 6500 -b 0.0.0.0 -l 1080 -m aes-256-cfb -k test123 --fast-open" -x -e "kcpclient" -k "-r SSSERVER_IP:6500 -l :6500 -mode fast2"
```

**以上命令相当于执行了** 

``` sh
ss-local -s 127.0.0.1 -p 6500 -b 0.0.0.0 -l 1080 -m aes-256-cfb -k test123 --fast-open 
kcpclient -r SSSERVER_IP:6500 -l :6500 -mode fast2
```

**关于 shadowsocks-libev 和 kcptun 都支持哪些参数请自行查阅官方文档，本镜像只做一个拼接**

**注意：kcptun 映射端口为 udp 模式(`6500:6500/udp`)，不写默认 tcp；shadowsocks 请监听 0.0.0.0**


### 环境变量支持


|环境变量|作用|取值|
|-------|---|---|
|SS_MODULE|shadowsocks 启动命令| `ss-local`、`ss-manager`、`ss-nat`、`ss-redir`、`ss-server`、`ss-tunnel`|
|SS_CONFIG|shadowsocks-libev 参数字符串|所有字符串内内容应当为 shadowsocks-libev 支持的选项参数|
|KCP_FLAG|是否开启 kcptun 支持|可选参数为 true 和 false，默认为 fasle 禁用 kcptun|
|KCP_MODULE|kcptun 启动命令| `kcpserver`、`kcpclient`|
|KCP_CONFIG|kcptun 参数字符串|所有字符串内内容应当为 kcptun 支持的选项参数|


使用时可指定环境变量，如下

``` sh
docker run -dt --name ss -p 6443:6443 -p 6500:6500/udp -e SS_CONFIG="-s 0.0.0.0 -p 6443 -m aes-256-cfb -k test123 --fast-open" -e KCP_MODULE="kcpserver" -e KCP_CONFIG="-t 127.0.0.1:6443 -l :6500 -mode fast2" -e KCP_FLAG="true" mritd/shadowsocks
```

### 容器平台说明

**各大免费容器平台都已经对代理工具做了对应封锁，一是为了某些不可描述的原因，二是为了防止被利用称为 DDOS 工具等；基于种种原因，公共免费容器平台问题将不予回复**

### 更新日志

- 2016-10-12 基于 shadowsocks 2.9.0 版本

基于 shadowsocks 2.9.0 版本打包 docker image

- 2016-10-13 增加 kcptun 支持

增加 kcptun 的支持，使用 `-x` 可关闭

- 2016-10-14 增加 环境变量支持

增加 默认读取环境变量策略，可通过环境变量指定 shadowsocks 相关设置

- 2016-11-01 升级 kcptun，增加 kcptun 自定义配置选项(-c 或 环境变量)

增加了 `-c` 参数和环境变量 `KCPTUN_CONFIG`，用于在不挂载文件的情况下重写 kcptun 的配置

- 2016-11-07 chacha20 加密支持

增加了 libsodium 库,用于支持 chacha20 加密算法(感谢 Lihang Chen 提出),删除了 wget 进一步精简镜像体积

- 2016-11-30 更新 kcptun 版本

更新 kcptun 版本到 20161118，修正样例命令中 kcptun 端口号使用 tcp 问题(应使用 udp)，感谢 Zheart 提出

- 2016-12-19 更新 kcptun 到 20161202

更新 kcptun 版本到 20161202，完善 README 中 kcptun 说明

- 2016-12-30 更新 kcptun 到 20161222

更新 kcptun 版本到 20161222，更新基础镜像 alpine 到 3.5

- 2017-01-20 升级 kcptun 到 20170117

更新 kcptun 到 20170117，kcptun 新版本 ack 结构中更准确的RTT估算，锁优化，更平滑的rtt计算jitter，
建议更新；同时 20170120 处于 Pre-release 暂不更新；**最近比较忙，可能 kcptun 配置已经有更新，具体
请参考 kcptun 官网及 [Github](https://github.com/xtaci/kcptun)**

- 2017-01-25 升级 kcptun 到 20171222

更新 kcptun 到 2017...... 别的我忘了......

- 2017-02-08 升级 kcptun 到 20170120

更新 kcptun 到 20170120，**下个版本准备切换到 shadowsocks-libev 3.0，目前 3.0 还未正式发布，观望中!**

- 2017-02-25 切换到 shadowsocks-libev

切换到 shadowsocks-libev 3.0 版本，同时更新 kcptun 和参数设定

- 2017-03-07 升级 kcptun 到 20170303

更新 kcptun 到 20170303

- 2017-03-09 升级 kcptun 到 20170308

更新 kcptun 到 20170308

- 2017-03-17 升级 kcptun 和 shadowsocks-libev

升级 shadowsocks-libev 到 3.0.4 版本，支持 `TCP Fast Open in ss-redir`、`TOS/DESCP in 
ss-redir` 和细化 MPTCP；升级 kcptun 到 315 打假版本 `(:`

- 2017-03-21 增加多命令支持

新增 `-m` 参数用于指定使用那个 shadowsocks 命令，如果作为客户端使用 `-m ss-local`,
不写的情况下默认为服务端命令，即 `ss-server`

- 2017-03-22 Bug 修复

修复增加 `-m` 参数后 SS_CONFIG 变量为空导致启动失败问题

- 2017-03-27 例行升级

升级 shadowsocks-libev 到 3.0.5、kcptun 到 20170322；kcptun 该版本主要做了 CPU 优化

- 2017-04-01 例行升级

升级 kcptun 到 20170329

- 2017-04-27 例行升级

升级 shadoscoks-libev 到 3.0.6

- 2017-05-31 例行升级

升级 kcptun 到 20150525

- 2017-06-28 例行升级

升级 shadowsocks 到 3.0.7

- 2017-07-28 例行升级

升级 shadowsocks 到 3.0.8

- 2017-08-09 obfs 支持

添加对 simple-obfs 支持

- 2017-08-23 kcptun client 支持

增加镜像对 kcptun client 支持

- 2017-11-38 例行升级

升级 shadowsocks-libev 到 3.1.0，升级 kcptun 到 20170904

- 2017-10-10 升级 kcptun

升级 kcptun 到 20170930

- 2017-11-2 update kcptun

升级 kcptun 到 20171021

- 2017-11-19 update kcptun

升级 kcptun 到 20171113

- 2017-11-22 Fix a security issue in ss-manager. (CVE-2017-15924)

Fix a security issue in ss-manager. (CVE-2017-15924)

- 2017-12-11 update base image

update base image

- 2017-12-27 update kcptun

update kcptun to 20171201

- 2018-01-2 update shadowsocks

update shadowsocks to 3.1.2(Fix a bug in DNS resolver;Add new TFO API support.)

- 2018-01-22 update shadowsocks

update shadowsocks to 3.1.3(Fix a bug in UDP relay.)
