#!/bin/bash

# Build the Go binary
go build -o universal-autotrade ./cmd/universal-autotrade

# Create temporary directory for DEB package
mkdir -p deb-package/usr/bin
mkdir -p deb-package/etc/systemd/system
mkdir -p deb-package/var/lib/universal-autotrade
mkdir -p deb-package/DEBIAN

# Copy files to DEB structure
cp universal-autotrade deb-package/usr/bin/
cp debian/control deb-package/DEBIAN/
cp debian/preinst deb-package/DEBIAN/
cp debian/postinst deb-package/DEBIAN/
cp debian/universal-autotrade.service deb-package/etc/systemd/system/

# Set permissions
chmod 755 deb-package/usr/bin/universal-autotrade
chmod 644 deb-package/etc/systemd/system/universal-autotrade.service
chmod 755 deb-package/DEBIAN/preinst
chmod 755 deb-package/DEBIAN/postinst
chmod 644 deb-package/DEBIAN/control
chmod 755 deb-package/var/lib/universal-autotrade

# Build DEB package
dpkg-deb --build deb-package universal-autotrade.deb

# Clean up
rm -rf deb-package universal-autotrade
