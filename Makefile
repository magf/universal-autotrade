.PHONY: all build run test clean deb

all: build

# Build the universal-autotrade binary
build:
	go build -o universal-autotrade ./cmd/universal-autotrade

# Run the universal-autotrade with default settings for testing
run: build
	./universal-autotrade -pair=BTCUSDT -exchange=bitget

# Run tests (placeholder, add tests to pkg/* if needed)
test:
	go test ./...

# Clean up generated files
clean:
	rm -f universal-autotrade universal-autotrade.deb
	rm -rf deb-package

# Build the DEB package
deb: build
	./scripts/build-deb.sh
