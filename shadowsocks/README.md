## shadowsocks

[![](https://images.microbadger.com/badges/image/mritd/shadowsocks.svg)](https://microbadger.com/images/mritd/shadowsocks "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/mritd/shadowsocks.svg)](https://microbadger.com/images/mritd/shadowsocks "Get your own version badge on microbadger.com")

- **shadowsocks 版本: 2.9.0**
- **kcptun 版本: 20161031**

### 打开姿势

``` sh
docker run -dt --name shadowsocks -p 5000:5000 mritd/shadowsocks -k mritd -w 2 -f
```

### 支持选项

- `-s` : SERVER_ADDR
- `-p` : SERVER_PORT
- `-k` : PASSWORD
- `-m` : METHOD
- `-t` : TIMEOUT
- `-w` : WORKERS
- `-a` : 启用 ONE_TIME_AUTH
- `-f` : 启用 FAST_OPEN
- `-i` : 启用 PREFER_IPV6
- `-x` : 禁用 kcptun

### 具体选项含义如下

``` sh
Proxy options:
  -c CONFIG              path to config file
  -s SERVER_ADDR         server address, default: 0.0.0.0
  -p SERVER_PORT         server port, default: 8388
  -k PASSWORD            password
  -m METHOD              encryption method, default: aes-256-cfb
  -t TIMEOUT             timeout in seconds, default: 300
  -a ONE_TIME_AUTH       one time auth
  --fast-open            use TCP_FASTOPEN, requires Linux 3.7+
  --workers WORKERS      number of workers, available on Unix/Linux
  --forbidden-ip IPLIST  comma seperated IP list forbidden to connect
  --manager-address ADDR optional server manager UDP address, see wiki
  --prefer-ipv6          resolve ipv6 address first

General options:
  -h, --help             show this help message and exit
  -d start/stop/restart  daemon mode
  --pid-file PID_FILE    pid file for daemon mode
  --log-file LOG_FILE    log file for daemon mode
  --user USER            username to run as
  -v, -vv                verbose mode
  -q, -qq                quiet mode, only show warnings/errors
  --version              show version information
```

### kcptun 支持

最新版本默认集成了 kcptun，打开姿势

``` sh
docker run -dt --name shadowsocks -v KCP_CFG_PATH:/etc/kcptun.cfg -p 5000:5000 -p 20000:20000 mritd/shadowsocks -k mritd -w 2 -f
```

kcptun 默认使用 `/etc/kcptun.cfg` 启动，默认配置见右侧 Github，自定义配置时只需要使用 `-v` 将本地配置挂载进去即可，如 `-v /root/kcptun.cfg:/etc/kcptun.cfg`；同时应使用 `-p` 增加 kcptun 对应的端口映射，默认配置监听 20000 端口；如不想使用 kcptun 可使用 `-x` 参数禁止

最新增加了 `-c` 参数和环境变量 `KCPTUN_CONFIG` 来支持命令行下自定义 kcptun 的配置，`-c` 命令后面要跟一个完整的 kcptun json 配置字符串，如下所示

``` sh
docker run -dt --name shadowsocks -p 5000:5000 -p 20000:20000 mritd/shadowsocks -k mritd -w 2 -f -c "{\"listen\":\":1111\",\"target\":\"127.0.0.1:5000\",\"key\":\"kcptun\",\"crypt\":\"salsa20\",\"mode\":\"fast2\",\"mtu\":1350,\"sndwnd\":1024,\"rcvwnd\":1024,\"datashard\":70,\"parityshard\":30,\"dscp\":46,\"nocomp\":false,\"acknodelay\":false,\"nodelay\":0,\"interval\":40,\"resend\":0,\"nc\":0,\"sockbuf\":4194304,\"keepalive\":10,\"log\":\"/var/log/kcptun.log\"}"
```

**json 字符串手动转义 `"` 可能有很大困难，可以借助 [JSON 在线格式化工具](http://www.bejson.com/zhuanyi/)，也就是说:首先自己修改好一个 kcptun 的配置文件，然后将里面的内容复制到上面的在线格式化工具中，选择压缩并转义；此时 json 字符串将被压缩成一行，同时内部 `"` 全部被转义，最后在启动的时候使用 `-c "压缩并转义后的内容"` 即可；注意一下不要忘记两边的双引号**

### 环境变量支持

14 号更新增加了对环境变量的支持，支持环境变量如下

|环境变量|作用|取值|
|-------|---|---|
|SERVER_ADDR|服务器监听地址|IPV4(一般为 0.0.0.0)|
|SERVER_PORT|服务器监听端口|0~65535|
|PASSWORD|shadowsocks 密码|任意字符 默认 `ZQoPF2g6uwJE7cy4`|
|METHOD|shadowsocks 加密方式|默认 aes-256-cfb|
|TIMEOUT|shadowsocks 链接超时时间|默认 300|
|WORKERS|shadowsocks 工作进程|默认 1|
|ONE_TIME_AUTH|是否启用 0TA|为空或 `-a`|
|FAST_OPEN|开启 fast-open|为空或 `--fast-open`|
|PREFER_IPV6|优先处理 IPV6|为空或 `--prefer-ipv6`|
|KCPTUN_FLAG|是否开启 kcptun 支持|`true` 或 `false`|
|KCPTUN_CONFIG|自定义 kcptun 配置|压缩并转义后的 kcptun 配置|

使用时可指定环境变量，如下

``` sh
docker run -dt --name shadowsocks -p 5000:5000 -e PASSWORD=ZQoPF2g6uwJE7cy4 -e FAST_OPEN=-a mritd/shadowsocks
```


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
