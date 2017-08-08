### LGTM Tool

> 这是一个类似于 GitLab EE LGTM 功能的小工具，可以通过指定 GitLab WebHooks 回调来触发 LGTM 机器人完成自动合并

### 如何使用

**启动 LGTM 服务器，如下( LGTM_TOKEN 为 GitLab 用户 AccessToken )**

``` sh
docker run -dt --name lgtm  -e LGTM_COUNT=1 \
                            -e LGTM_PORT=8989 \
                            -e LGTM_TOKEN=mp3fzN3b4dBUxn9c \
                            -e LGTM_GITLAB_URL=https://gitlab.com \
                            -p 8989:8989 \
                            mritd/lgtm
```

**新建 LGTM 用户，并赋予相应项目的合并权限；同时获取该用户的 AccessToken 作为 LGTM 服务器 Token 和回调 Token**

![LGTM User](http://imgur.com/abW1BHo.jpg)

**配置 GitLab 项目的回调地址**


![GitLab WebHook](http://i.imgur.com/Wkt4PoN.jpg)


**配置完成后，发起 PR 在其下 回复 `LGTM` 即可完成自动合并**
