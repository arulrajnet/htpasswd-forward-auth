# Variables
GO_BUILD=go build
OUTPUT_DIR=./dist


# Targets
.PHONY: all clean

all: build

build: build_linux_amd64 build_linux_arm build_linux_amd64_alpine build_windows_amd64

# Build for different platforms
build_linux_amd64:
	GOOS=linux GOARCH=amd64 $(GO_BUILD) -o $(OUTPUT_DIR)/htpasswd-forward-auth_amd64 ./cmd/main.go

build_linux_arm:
	GOOS=linux GOARCH=arm $(GO_BUILD) -o $(OUTPUT_DIR)/htpasswd-forward-auth_arm ./cmd/main.go

build_linux_amd64_alpine:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 $(GO_BUILD) -o $(OUTPUT_DIR)/htpasswd-forward-auth_alpine ./cmd/main.go

build_windows_amd64:
	GOOS=windows GOARCH=amd64 $(GO_BUILD) -o $(OUTPUT_DIR)/htpasswd-forward-auth_windows.exe ./cmd/main.go

# Clean up binaries
clean:
	rm -rf $(OUTPUT_DIR)/*
