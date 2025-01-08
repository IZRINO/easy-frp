# 开发环境的Docker镜像构建

# 使用官方的Ubuntu镜像作为基础
FROM ubuntu:22.04 AS dev

LABEL author="IZRINO sxnull@163.com"
LABEL version="1.0"
LABEL description="此项目的开发容器镜像"
LABEL build-date="2025-1-3"
LABEL environment="dev"

SHELL ["/bin/bash","-c"]

# 更新包列表并安装必要的工具
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl=7.81.0-1ubuntu1.20 \
    git=1:2.34.1-1ubuntu1.11 \
    make=4.3-4.1build1 \
    xz-utils=5.2.5-2ubuntu1 \
    bison=2:3.8.2+dfsg-1build1 \
    ed=1.18-1 \
    gawk=1:5.1.0-1ubuntu0.1 \
    gcc=4:11.2.0-1ubuntu1 \
    gdb=12.1-0ubuntu1~22.04.2 \
    libc6-dev=2.35-0ubuntu3.8 \
    wget=1.21.2-2ubuntu1.1 \
    ca-certificates=20240203~22.04.1 \
    && rm -rf /var/lib/apt/lists/*  # 清理apt缓存

# 下载并解压Node.js
ENV PATH="/usr/local/node/bin:${PATH}"
ENV PATH="/usr/local/node/lib/node_modules:$PATH"
WORKDIR /usr/local/
RUN wget -q https://mirrors.cloud.tencent.com/nodejs-release/v22.12.0/node-v22.12.0-linux-x64.tar.xz \
    && tar xf node-v22.12.0-linux-x64.tar.xz \
    && mv node-v22.12.0-linux-x64 node \
    && rm -rf node-v22.12.0-linux-x64.tar.xz \
    # 下载安装GO
    && wget -q https://golang.google.cn/dl/go1.23.4.linux-amd64.tar.gz \
    && tar zxf go1.23.4.linux-amd64.tar.gz \
    && rm -rf go1.23.4.linux-amd64.tar.gz  \
    # 设置npm镜像
    && npm config set registry https://mirrors.cloud.tencent.com/npm/ \
    # && npm config set registry https://registry.npmmirror.com \
    && npm config set strict-ssl false \
    && npm config delete proxy && npm config delete https-proxy \
    && npm install -g pnpm@latest-10  # 安装pnpm \
    && pnpm config set registry https://mirrors.cloud.tencent.com/npm/
# && pnpm config set registry https://registry.npmmirror.com

# 设置Go环境变量
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"

# 设置工作目录
WORKDIR /code/NAT-UI

RUN go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://mirrors.cloud.tencent.com/go/,direct
# && go env -w GOPROXY=https://goproxy.cn,direct
# 默认命令
CMD ["/bin/bash"]

# 声明开放的端口
EXPOSE 4321 9999
