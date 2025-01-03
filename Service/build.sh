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

cd ./web
sudo rm -rf .astro
sudo rm -rf node_modules

pnpm i
pnpm build
sudo rm -rf ../dist 
sudo mv -f dist/ ../
cd ../

# 传递目标平台和架构给Makefile
make build TARGETS="$TARGETS" ARCHS="$ARCHS"
sudo rm -rf dist