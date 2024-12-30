# 开发环境的Docker镜像构建

# 使用官方的Ubuntu镜像作为基础
FROM ubuntu:latest AS dev

# 更新包列表并安装必要的工具
RUN apt-get update && apt-get install -y curl git make xz-utils bison ed gawk gcc libc6-dev wget \
    && rm -rf /var/lib/apt/lists/*  # 清理apt缓存

# 下载并解压Node.js
ENV PATH="/usr/local/node/bin:${PATH}"
ENV PATH="/usr/local/node/lib/node_modules:$PATH"
RUN cd /usr/local/ && wget https://mirrors.cloud.tencent.com/nodejs-release/v22.12.0/node-v22.12.0-linux-x64.tar.xz \
    && tar xvf node-v22.12.0-linux-x64.tar.xz \
    && mv node-v22.12.0-linux-x64 node \
    && rm -rf node-v22.12.0-linux-x64.tar.xz  # 清理nodejs的tar包

# 设置npm镜像
RUN npm config set registry https://mirrors.cloud.tencent.com/npm/ \
    && npm config set strict-ssl false \
    && npm config delete proxy && npm config delete https-proxy \
    && npm install -g pnpm  # 安装pnpm

# 下载安装GO
RUN cd /usr/local/ && wget https://golang.google.cn/dl/go1.23.4.linux-amd64.tar.gz \
    && tar zxvf go1.23.4.linux-amd64.tar.gz \
    && rm -rf go1.23.4.linux-amd64.tar.gz  # 清理go的tar包

# 设置Go环境变量
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"

# 设置工作目录
WORKDIR /code/NAT-UI

RUN go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://mirrors.cloud.tencent.com/go/,direct

# 默认命令
CMD ["/bin/bash"]

# 声明开放的端口
EXPOSE 4321 9999