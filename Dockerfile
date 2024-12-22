#开发环境的Docker镜像构建

# 使用官方的Ubuntu镜像作为基础
FROM ubuntu:latest AS dev

# 更新包列表并安装必要的工具
RUN apt-get update && apt-get install -y curl git make xz-utils openssh-server bison ed gawk gcc libc6-dev make

# 下载并解压Node.js
RUN cd /usr/local/ && wget https://nodejs.org/dist/v22.12.0/node-v22.12.0-linux-x64.tar.xz \
    && tar Jxvf node-v22.12.0-linux-x64.tar.xz \
    && mv node-v22.12.0-linux-x64 node \
    && rm -rf node-v22.12.0-linux-x64.tar.xz \
    # 清理nodejs的tar包
    && rm -rf node-v22.12.0-linux-x64.tar.xz \
    # 安装pnpm
    && npm install -g pnpm

ENV PATH="/usr/local/node/bin:${PATH}"
ENV PATH="/usr/local/node/lib/node_modules:$PATH"
#下载安装GO
RUN cd /usr/local/ && wget https://go.dev/dl/go1.23.4.linux-amd64.tar.gz \
    && tar zxvf go1.23.4.linux-amd64.tar.gz \
    && rm -rf go1.23.4.linux-amd64.tar.gz

# 设置Go环境变量
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"

# 设置工作目录
WORKDIR /usr/src/app

RUN git clone https://github.com/IZRINO/Nat-UI \
    && go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://goproxy.cn,direct


# 默认命令
CMD ["/bin/bash"]
# 声明开放的端口
EXPOSE 22 4321 9999
