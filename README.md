# NAT-UI

这是一个用于简化网络穿透操作的项目，提供一个服务器页面与一个客户端应用

这只是一个用于简化操作并提供一个好看的界面的项目，内核是 [`frp`](https://github.com/fatedier/frp) 与 [`bore`](https://github.com/ekzhang/bore)

[frp文档](https://gofrp.org/zh-cn/)

# 开发环境
根目录下使用此命令启动开发环境
```shell
docker-compose up -d
```
可以使用vscode打开远程目录直接在容器内写代码，或使用docker exec，仅使用控制台