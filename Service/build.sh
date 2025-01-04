#!/bin/bash

# 默认目标平台和架构
TARGETS="windows linux darwin"
ARCHS="amd64 arm64 386"

# 解析脚本参数
while [[ $# -gt 0 ]]; do
  case "$1" in
  -t=*)
    TARGETS="${1#*=}"
    shift
    ;;
  -a=*)
    ARCHS="${1#*=}"
    shift
    ;;
  *)
    echo "Unknown parameter: $1"
    exit 1
    ;;
  esac
done

make clean

make front

# 传递目标平台和架构给Makefile
make build TARGETS="$TARGETS" ARCHS="$ARCHS"
rm -rf dist
