# 项目名称
PROJECT_NAME := Service

# 版本号
VERSION := 0.0.1

# 目标平台
TARGETS := windows linux darwin

# 目标架构
ARCHS := amd64 arm64 386

# 输出目录
OUTPUT_DIR := target

# 构建命令
build: $(foreach target,$(TARGETS),$(foreach arch,$(ARCHS),$(OUTPUT_DIR)/$(PROJECT_NAME)-$(VERSION)-$(target)-$(arch)))

# 带参数的构建命令
build-%:
	@$(MAKE) build TARGETS=$*

build-%-%:
	@$(MAKE) build TARGETS=$* ARCHS=$(lastword $(subst -, ,$*))

# 构建规则
$(OUTPUT_DIR)/$(PROJECT_NAME)-$(VERSION)-%:
	@echo "Building for $*"
	@mkdir -p $(OUTPUT_DIR)
	@if [ "$(firstword $(subst -, ,$*))" = "darwin" ] && [ "$(lastword $(subst -, ,$*))" = "386" ]; then \
		echo "Skipping darwin-386 build"; \
	else \
		GOOS=$(firstword $(subst -, ,$*)) GOARCH=$(lastword $(subst -, ,$*)) go build -o $(if $(findstring windows,$(firstword $(subst -, ,$*))),$@.exe,$@) main.go; \
	fi

# 清理命令
clean:
	@echo "Cleaning up..."
	@rm -rf $(OUTPUT_DIR) && rm -rf dist
	@cd web && rm -rf dist
	@echo "Cleaning complete"

# 构建前端
front:
	@echo "Building frontend..."
	@cd web && pnpm install && pnpm build
	@mv web/dist .
	@echo "Frontend build complete"
# 默认目标
.PHONY: build clean