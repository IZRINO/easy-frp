# 项目名称
PROJECT_NAME := Service

# 目标平台
TARGETS := windows linux darwin

# 目标架构
ARCHS := amd64 386 arm64

# 输出目录
OUTPUT_DIR := target

# 构建命令
build: $(foreach target,$(TARGETS),$(foreach arch,$(ARCHS),$(OUTPUT_DIR)/$(PROJECT_NAME)-$(target)-$(arch)))

# 构建规则
$(OUTPUT_DIR)/$(PROJECT_NAME)-%-amd64:
	@echo "Building for $* amd64..."
	@mkdir -p $(OUTPUT_DIR)
	@GOOS=$* GOARCH=amd64 go build -o $(OUTPUT_DIR)/$(PROJECT_NAME)-$*-amd64 main.go

$(OUTPUT_DIR)/$(PROJECT_NAME)-%-386:
	@echo "Building for $* 386..."
	@mkdir -p $(OUTPUT_DIR)
	@GOOS=$* GOARCH=386 go build -o $(OUTPUT_DIR)/$(PROJECT_NAME)-$*-386 main.go

$(OUTPUT_DIR)/$(PROJECT_NAME)-%-arm64:
	@echo "Building for $* arm64..."
	@mkdir -p $(OUTPUT_DIR)
	@GOOS=$* GOARCH=arm64 go build -o $(OUTPUT_DIR)/$(PROJECT_NAME)-$*-arm64 main.go

# 清理命令
clean:
	@echo "Cleaning up..."
	@rm -rf $(OUTPUT_DIR)

# 默认目标
.PHONY: build clean