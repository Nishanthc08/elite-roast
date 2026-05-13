#!/bin/bash
# build.sh - builds the elite-roast deb package
# run this from the repo root

set -e

VERSION="1.0"
PKG="elite-roast_${VERSION}_all"

echo "building $PKG.deb ..."

# reproducible build - timestamp locked to latest git commit
# if not in a git repo, fall back to a fixed date
if git rev-parse --git-dir > /dev/null 2>&1; then
    export SOURCE_DATE_EPOCH=$(git log -1 --format=%ct)
else
    export SOURCE_DATE_EPOCH=1775413800
fi

# build directory structure
rm -rf /tmp/$PKG
mkdir -p /tmp/$PKG/DEBIAN
mkdir -p /tmp/$PKG/usr/share/elite-roast
mkdir -p /tmp/$PKG/usr/share/doc/elite-roast
mkdir -p /tmp/$PKG/usr/share/man/man1
mkdir -p /tmp/$PKG/usr/share/lintian/overrides
mkdir -p /tmp/$PKG/usr/bin

# copy files
cp roast.sh       /tmp/$PKG/usr/share/elite-roast/
cp roasts.sh      /tmp/$PKG/usr/share/elite-roast/
cp roast-stats    /tmp/$PKG/usr/bin/
cp debian/control /tmp/$PKG/DEBIAN/
cp debian/postinst /tmp/$PKG/DEBIAN/
cp debian/prerm   /tmp/$PKG/DEBIAN/

# changelog
gzip -9 -n -c debian/changelog > /tmp/$PKG/usr/share/doc/elite-roast/changelog.gz

# copyright
cp debian/copyright /tmp/$PKG/usr/share/doc/elite-roast/

# man page
gzip -9 -n -c debian/roast-stats.1 > /tmp/$PKG/usr/share/man/man1/roast-stats.1.gz

# lintian override
cp debian/lintian-overrides /tmp/$PKG/usr/share/lintian/overrides/elite-roast

# permissions
chmod 755 /tmp/$PKG/DEBIAN/postinst
chmod 755 /tmp/$PKG/DEBIAN/prerm
chmod 755 /tmp/$PKG/usr/bin/roast-stats
chmod 755 /tmp/$PKG/usr/share/elite-roast/roast.sh
chmod 755 /tmp/$PKG/usr/share/elite-roast/roasts.sh

# build
chown -R root:root /tmp/$PKG
dpkg-deb --build /tmp/$PKG ${PKG}.deb

echo ""
echo "built: ${PKG}.deb"
echo "size:  $(du -h ${PKG}.deb | cut -f1)"
echo ""
echo "verify with:"
echo "  dpkg-deb --info ${PKG}.deb"
echo "  lintian ${PKG}.deb"
