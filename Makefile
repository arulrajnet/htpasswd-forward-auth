# Variables
GO_BUILD=go build
OUTPUT_DIR=./dist
GOLANGCILINT=golangci-lint
BINERY=htpasswd-forward-auth


# Targets
.PHONY: all
all: build

.PHONY: build
build: clean build_linux_amd64 build_linux_arm build_windows_amd64

.PHONY: build_binary
build_binary: clean $(BINERY)

.PHONY: lint
lint:
	$(GOLANGCILINT) run

# Build for given platform. The arch and os set outside of the makefile
.PHONY: $(BINERY)
$(BINERY): clean
	CGO_ENABLED=0 $(GO_BUILD) -a -installsuffix cgo -ldflags="-X github.com/arulrajnet/htpasswd-forward-auth/pkg/version.VERSION=${VERSION}" -o $(OUTPUT_DIR)/$(BINERY) ./cmd/main.go

# Build for different platforms
.PHONY: build_linux_amd64
build_linux_amd64:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 $(GO_BUILD) -a -installsuffix cgo -ldflags="-X github.com/arulrajnet/htpasswd-forward-auth/pkg/version.VERSION=${VERSION}" -o $(OUTPUT_DIR)/$(BINERY)_amd64 ./cmd/main.go

.PHONY: build_linux_arm
build_linux_arm:
	GOOS=linux GOARCH=arm CGO_ENABLED=0 $(GO_BUILD) -a -installsuffix cgo -ldflags="-X github.com/arulrajnet/htpasswd-forward-auth/pkg/version.VERSION=${VERSION}" -o $(OUTPUT_DIR)/$(BINERY)_arm ./cmd/main.go

.PHONY: build_windows_amd64
build_windows_amd64:
	GOOS=windows GOARCH=amd64 CGO_ENABLED=0 $(GO_BUILD) -a -installsuffix cgo -ldflags="-X github.com/arulrajnet/htpasswd-forward-auth/pkg/version.VERSION=${VERSION}" -o $(OUTPUT_DIR)/$(BINERY)_windows.exe ./cmd/main.go

# Clean up binaries
.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR)/*
