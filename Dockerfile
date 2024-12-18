# 使用官方的Ubuntu镜像作为基础
FROM ubuntu:latest
FROM golang:latest
FROM node:22-alpine
# 设置工作目录
WORKDIR /usr/src/app
# 更新包列表并安装必要的工具
RUN apt-get update && apt-get install -y \
    curl git make && \
    # 安装pnpm
    npm install -g pnpm

# 设置Go环境变量
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"

# 默认命令
CMD ["/bin/bash"]