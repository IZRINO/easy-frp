#开发环境的Docker镜像构建

# 使用官方的Ubuntu镜像作为基础
FROM ubuntu:latest AS base


# 更新包列表并安装必要的工具
RUN apt-get update && apt-get install -y curl git make xz-utils &&\
    # 下载并解压Node.js
    curl -fsSL https://nodejs.org/dist/v22.12.0/node-v22.12.0-linux-x64.tar.xz | tar -xJ -C /usr/local --strip-components=1 &&\
    # 清理nodejs的tar包
    rm -f node-v22.12.0-linux-x64.tar.xz &&\
    # 安装pnpm
    wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.shrc" SHELL="$(which sh)" sh - &&\
    # 清理不必要的文件
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/local/node/bin:${PATH}"


# 使用Golang镜像
FROM golang:1.23 AS go

# 设置工作目录
WORKDIR /usr/src/app

RUN git clone https://github.com/IZRINO/Nat-UI \
    && go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://goproxy.cn,direct

# 设置Go环境变量
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"

# 默认命令
CMD ["/bin/bash"]