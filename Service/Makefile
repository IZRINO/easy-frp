# 项目名称
PROJECT_NAME := Service

# 版本号
VERSION := 0.0.1

# 目标平台
TARGETS := windows linux darwin

# 目标架构
ARCHS := amd64 arm64

# 输出目录
OUTPUT_DIR := target

# 构建命令
build: $(foreach target,$(TARGETS),$(foreach arch,$(ARCHS),$(OUTPUT_DIR)/$(PROJECT_NAME)-$(VERSION)-$(target)-$(arch)))

# 构建规则
$(OUTPUT_DIR)/$(PROJECT_NAME)-$(VERSION)-windows-%:
	@echo "Building for windows $*"
	@mkdir -p $(OUTPUT_DIR)
	@GOOS=windows GOARCH=$* go build -o $(OUTPUT_DIR)/$(PROJECT_NAME)-$(VERSION)-windows-$*.exe main.go

$(OUTPUT_DIR)/$(PROJECT_NAME)-$(VERSION)-linux-%:
	@echo "Building for linux $*"
	@mkdir -p $(OUTPUT_DIR)
	@GOOS=linux GOARCH=$* go build -o $(OUTPUT_DIR)/$(PROJECT_NAME)-$(VERSION)-linux-$* main.go

$(OUTPUT_DIR)/$(PROJECT_NAME)-$(VERSION)-darwin-%:
	@echo "Building for darwin $*"
	@mkdir -p $(OUTPUT_DIR)
	@GOOS=darwin GOARCH=$* go build -o $(OUTPUT_DIR)/$(PROJECT_NAME)-$(VERSION)-darwin-$* main.go

# 清理命令
clean:
	@echo "Cleaning up..."
	@rm -rf $(OUTPUT_DIR) && rm -rf dist
	@cd web && rm -rf dist
	@echo "Cleaning complete"

# 默认目标
.PHONY: build clean