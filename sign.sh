#!/bin/bash
# sign.sh - GPG sign the deb package
# run this after build.sh
# requires: gpg key set up with the same email as in debian/control

set -e

PKG="elite-roast_1.0_all.deb"
EMAIL="nishanthc264@gmail.com"

if [ ! -f "$PKG" ]; then
    echo "error: $PKG not found. run build.sh first."
    exit 1
fi

# check if gpg key exists for this email
if ! gpg --list-secret-keys "$EMAIL" > /dev/null 2>&1; then
    echo "no GPG key found for $EMAIL"
    echo ""
    echo "generate one with:"
    echo "  gpg --gen-key"
    echo "  (use $EMAIL as the email)"
    exit 1
fi

# install dpkg-sig if not present
if ! command -v dpkg-sig &> /dev/null; then
    sudo apt-get install -y dpkg-sig
fi

echo "signing $PKG ..."
dpkg-sig --sign builder -k "$EMAIL" "$PKG"

echo ""
echo "verifying signature ..."
dpkg-sig --verify "$PKG"

echo ""
echo "done. $PKG is signed and verified."
