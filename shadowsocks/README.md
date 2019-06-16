## shadowsocks

![](https://img.shields.io/docker/stars/mritd/shadowsocks.svg) ![](https://img.shields.io/docker/pulls/mritd/shadowsocks.svg) ![](https://img.shields.io/microbadger/image-size/mritd/shadowsocks.svg) ![](https://img.shields.io/microbadger/layers/mritd/shadowsocks.svg)

- **shadowsocks-libev 版本: 3.2.5**
- **kcptun 版本: 20190424**

**注意: 由于 Docker Hub 自动构建功能最近出现的 Bug 比较多，构建队列缓慢；部分镜像(包含本镜像)可能会在采用本地 Build 然后直接 push 到远程仓库的方式构建；如有安全疑虑，可自行实用本 Dockerfile 构建**

### 打开姿势

``` sh
docker run -dt --name ss -p 6443:6443 mritd/shadowsocks -s "-s 0.0.0.0 -p 6443 -m chacha20-ietf-poly1305 -k test123"
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
docker run -dt --name ssserver -p 6443:6443 -p 6500:6500/udp mritd/shadowsocks -m "ss-server" -s "-s 0.0.0.0 -p 6443 -m chacha20-ietf-poly1305 -k test123" -x -e "kcpserver" -k "-t 127.0.0.1:6443 -l :6500 -mode fast2"
```

**以上命令相当于执行了**

``` sh
ss-server -s 0.0.0.0 -p 6443 -m chacha20-ietf-poly1305 -k test123
kcpserver -t 127.0.0.1:6443 -l :6500 -mode fast2
```

**Client 端**

``` sh
docker run -dt --name ssclient -p 1080:1080 mritd/shadowsocks -m "ss-local" -s "-s 127.0.0.1 -p 6500 -b 0.0.0.0 -l 1080 -m chacha20-ietf-poly1305 -k test123" -x -e "kcpclient" -k "-r SSSERVER_IP:6500 -l :6500 -mode fast2"
```

**以上命令相当于执行了** 

``` sh
ss-local -s 127.0.0.1 -p 6500 -b 0.0.0.0 -l 1080 -m chacha20-ietf-poly1305 -k test123
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
docker run -dt --name ss -p 6443:6443 -p 6500:6500/udp -e SS_CONFIG="-s 0.0.0.0 -p 6443 -m chacha20-ietf-poly1305 -k test123" -e KCP_MODULE="kcpserver" -e KCP_CONFIG="-t 127.0.0.1:6443 -l :6500 -mode fast2" -e KCP_FLAG="true" mritd/shadowsocks
```

### 容器平台说明

**各大免费容器平台都已经对代理工具做了对应封锁，一是为了某些不可描述的原因，二是为了防止被利用称为 DDOS 工具等；基于种种原因，公共免费容器平台问题将不予回复**

### GCE 随机数生成错误

如果在 GCE 上使用本镜像，在特殊情况下可能会出现 `This system doesn't provide enough entropy to quickly generate high-quality random numbers.` 错误；
这种情况是由于宿主机没有能提供足够的熵来生成随机数导致，修复办法可以考虑增加 `--device /dev/urandom:/dev/urandom` 选项来使用 `/dev/urandom` 来生成，不过并不算推荐此种方式

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

- 2018-03-11 update kcptun

update kcptun to 20180305

- 2018-03-23 update kcptun

update kcptun to 20180316(fix 'too man open files')

- 2018-05-29 update shadowsocks

update shadowsocks to 3.2.0(Add MinGW,Refine c-ares integration...)

- 2018-07-09 update base image

update base image to alpine 3.8

- 2018-08-05 fix high-quality random numbers

fix `system doesn't provide enough entropy to quickly generate high-quality random numbers`

- 2018-08-16 update kcptun

update kcptun to v20180810

- 2018-09-27 update kcptun

update kcptun to v20180926

- 2018-11-06 add `-r` option

update kcptun to v20181002
add `-r` option to fix GCE `system doesn't provide enough entropy...` error

- 2018-11-14 update shadowsocks

update shadowsocks to v3.2.1

- 2018-11-15 update kcptun

update kcptun to v20181114

- 2018-12-14 update shadowsocks

update shadowsocks to v3.2.3

- 2018-12-26 update kcptun

update kcptun to v20181224

- 2019-01-10 update kcptun

update kcptun to v20190109

- 2019-01-23 add v2ray-plugin

add v2ray-plugin support

- 2019-02-26 update to v3.2.4

update shadowsocks to v3.2.4

- 2019-04-14 update to v3.2.5

update shadowsocks to v3.2.5, update kcptun to v20190409

- 2019-04-24 update kcptun

update kcptun to v20190424

- 2019-04-29 add runit

add runit, remove rng-tools

- 2019-06-16 update kcptun

update kcptun to v20190611
