## v2ray 最新版本

[![](https://images.microbadger.com/badges/version/mritd/v2ray.svg)](https://microbadger.com/images/mritd/v2ray "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/mritd/v2ray.svg)](https://microbadger.com/images/mritd/v2ray "Get your own image badge on microbadger.com")

> 截至目前该镜像为 v2ray 3.29 版本

### 打开姿势

``` sh
docker pull mritd/v2ray
docker run -dt --name v2ray -p 10086:10086 mritd/v2ray
```

**Container 默认监听 10086 端口**
**v2ray 默认 ID 为 `23ad6b10-8d1a-40f7-8ad0-e3e35cd38297`(不保证后期变动)**

### 自定义配置

**镜像支持写入自定义的 v2ray 配置，挂载覆盖 `/etc/v2ray/config.json` 或使用 `-c` 选项并跟上 JSON 字符串即可，如下所示**

``` sh
docker run -dt --name v2ray mritd/v2ray -c "{\"log\" : {     \"access\": \"/var/log/v2ray/access.log\",     \"error\": \"/var/log/v2ray/error.log\",     \"loglevel\": \"warning\"   },   \"inbound\": {     \"port\": 4500,     \"protocol\": \"vmess\",     \"settings\": {       \"clients\": [         {           \"id\": \"23ad6b10-8d1a-40f7-8ad0-e3e35cd38297\",           \"level\": 1,           \"alterId\": 64         }       ]     }   },   \"outbound\": {     \"protocol\": \"freedom\",     \"settings\": {}   },   \"outboundDetour\": [     {       \"protocol\": \"blackhole\",       \"settings\": {},       \"tag\": \"blocked\"     }   ], \"routing\": {     \"strategy\": \"rules\",     \"settings\": {       \"rules\": [         {           \"type\": \"field\",           \"ip\": [             \"0.0.0.0/8\",             \"10.0.0.0/8\",             \"100.64.0.0/10\",             \"127.0.0.0/8\",             \"169.254.0.0/16\",             \"172.16.0.0/12\",             \"192.0.0.0/24\",             \"192.0.2.0/24\",             \"192.168.0.0/16\",             \"198.18.0.0/15\",             \"198.51.100.0/24\",             \"203.0.113.0/24\",             \"::1/128\",             \"fc00::/7\",             \"fe80::/10\"           ],           \"outboundTag\": \"blocked\"         }       ]     }   },   \"transport\": {     \"kcpSettings\": {       \"uplinkCapacity\": 10,       \"downlinkCapacity\": 10     }   } }"
```

**`-c` 选项后面的参数就是改好的配置文件中的 JSON 字符串**
**实际上对于怎么处理那个 JSON 中引号懵逼的朋友可以借助 JSON
在线转换工具 [http://www.bejson.com/zhuanyi/](http://www.bejson.com/zhuanyi/) 完成 JSON 字符串转换**
**也就是说先改好配置，然后将 JSON 复制到上面的网站，选择压缩并转义转换一下，
最后将压缩并转义后的内容拼接在 `-c` 选项后即可**
**注意: 网站转换完的两边没有双引号，也就是说要 `-c "粘贴压缩并转义后的内容"`**

### 样例配置

**镜像使用官方的样例配置，来源于官方发布包，可执行以下命令获取样例配置**
**具体修改设置请参考 [官方文档配置部分](https://www.v2ray.com/chapter_02/)**

``` sh
docker run --rm mritd/v2ray "cat /etc/v2ray/config.json" > config.json
```
