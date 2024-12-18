# 使用官方的Ubuntu镜像作为基础
FROM ubuntu:latest AS base

# 更新包列表并安装必要的工具
RUN apt-get update && apt-get install -y \
    curl git make

# 安装pnpm
RUN npm install -g pnpm

# 克隆仓库
RUN git clone https://github.com/IZRINO/Nat-UI

# 设置工作目录
WORKDIR /usr/src/app

# 使用Golang镜像
FROM golang:latest AS go

# 设置Go环境变量
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"

# 使用Node镜像
FROM node:22-alpine

# 从base阶段复制文件
COPY --from=base /usr/src/app /usr/src/app

# 从go阶段复制Go环境变量
COPY --from=go /usr/local/go /usr/local/go
COPY --from=go /go /go

# 默认命令
CMD ["/bin/bash"]