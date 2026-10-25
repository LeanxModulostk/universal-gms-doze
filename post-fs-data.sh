#!/data/adb/magisk/busybox sh
set -o standalone

#
# Universal GMS Doze by the
# open-source loving GL-DP and all contributors;
# Patches Google Play services app and certain processes/services to be able to use battery optimization
#

#!/system/bin/sh

MODDIR=${0%/*}

# Bind mount every patched file under my_product over its original
#if [ -d "$MODDIR/my_product" ]; then
#find "$MODDIR/my_product" -type f | while IFS= read -r SRC; do
#DST="${SRC#$MODDIR}"
#[ -f "$DST" ] && mount -o bind "$SRC" "$DST"
#done
#fi


# Search and patch any conflicting modules (if present)

PKGS="com.google.android.gms com.android.vending"
TAGS="allow-unthrottled-location allow-ignore-location-settings allow-in-power-save allow-in-data-usage-save"
XPKG="com.android.vending"
XTAGS="allow-in-power-save-except-idle"
NULL="/dev/null"

find /data/adb/* -type f -iname "*.xml" -print |
while IFS= read -r XML; do
for P in $PKGS; do
for T in $TAGS; do
if grep -qF "$T package=\"$P\"" "$XML" 2> "$NULL"; then
sed -i "\|$T package=\"$P\"|d" "$XML"
fi
done
done
for T in $XTAGS; do
if grep -qF "$T package=\"$XPKG\"" "$XML" 2> "$NULL"; then
sed -i "\|$T package=\"$XPKG\"|d" "$XML"
fi
done
done
