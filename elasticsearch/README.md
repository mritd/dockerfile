### Elasticsearch 5

> 这是一个 Elasticsearch 5 的 Dokcer 镜像，基于 alpine openJDK8 制作，参考了官方 alpine Dockerfile，自己又造了一个轮子。


#### 配置说明

**默认情况下该镜像预设 2G JVM 内存，使用前可能需要调整内核 `vm.max_map_count` 参数，否则可能出现如下错误**

``` sh
max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
```

**Elasticsearch 被安装在 `/usr/local/elasticsearch` 目录，配置文件位于安装目录的 `config` 目录中，请自行修改；Elasticsearch 数据默认存储在 `/data/elasticsearch` 目录，日志默认存放在 `/var/log/elasticsearch`**


