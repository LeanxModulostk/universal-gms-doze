#!/data/adb/magisk/busybox sh
set -o standalone

set -x

#
# Universal GMS Doze by the
# open-source loving GL-DP and all contributors;
# Patches Google Play services app and certain processes/services to be able to use battery optimization
#

# Check root implementation
ui_print "- Checking root implementation"
if [ "$BOOTMODE" ] && [ "$KSU" ]; then
ui_print "- Installing from KernelSU app"
ui_print "   KernelSU version: $KSU_KERNEL_VER_CODE (kernel) + $KSU_VER_CODE (ksud)"
if [ "$(which magisk)" ]; then
ui_print "   Multiple root implementation is NOT supported"
abort    "   Aborting!"
fi
elif [ "$BOOTMODE" ] && [ "$MAGISK_VER_CODE" ]; then
ui_print "- Installing from Magisk app"
else
ui_print "   Installation from recovery is NOT supported"
ui_print "   Please install from Magisk / KernelSU app"
abort    "   Aborting!"
fi

# Check Android API
[ $API -ge 23 ] ||
abort "- Unsupported API version: $API"

# Patch the XML and place the modified one to the original directory
ui_print "- Patching XML files"
PKGS="com.google.android.gms com.android.vending"
TAGS="allow-in-power-save allow-in-data-usage-save allow-unthrottled-location allow-ignore-location-settings"
XPKG="com.android.vending"
XTAGS="allow-in-power-save-except-idle"
NULL="/dev/null"

# Return 0 if the file has any entry to be removed
HAS_ENTRY() {
for P in $PKGS; do
for T in $TAGS; do
grep -qF "$T package=\"$P\"" "$1" 2> "$NULL" && return 0
done
grep -qF "<wl>$P</wl>" "$1" 2> "$NULL" && return 0
done
for T in $XTAGS; do
grep -qF "$T package=\"$XPKG\"" "$1" 2> "$NULL" && return 0
done
return 1
}

# Remove every entry from the file
STRIP_ENTRY() {
for P in $PKGS; do
for T in $TAGS; do
sed -i "\|$T package=\"$P\"|d" "$1"
done
sed -i "\|<wl>$P</wl>|d" "$1"
done
for T in $XTAGS; do
sed -i "\|$T package=\"$XPKG\"|d" "$1"
done
}

ui_print "- Searching default XML files"
SYS_XML="$(
SXML="$(find /system_ext/* /my_product/* /system/* /product/* \
/vendor/* /india/* /my_bigball/* -type f -iname '*.xml' -print)"
for S in $SXML; do
if HAS_ENTRY "$ROOT$S"; then
echo "$S"
fi
done
)"

PATCH_SX() {
for SX in $SYS_XML; do
mkdir -p "$(dirname $MODPATH$SX)"
cp -af $ROOT$SX $MODPATH$SX
ui_print "  Patching: $SX"
STRIP_ENTRY "$MODPATH/$SX"
done

# Merge patched files under /system dir
for P in product vendor system_ext; do
if [ -d $MODPATH/$P ]; then
ui_print "- Moving files to module directory"
mkdir -p $MODPATH/system/$P
mv -f $MODPATH/$P $MODPATH/system/
fi
done
}

# Search and patch any conflicting modules (if present)
# Search conflicting XML files
MOD_XML="$(
MXML="$(find /data/adb/* -type f -iname "*.xml" -print)"
for M in $MXML; do
if HAS_ENTRY "$M"; then
echo "$M"
fi
done
)"

PATCH_MX() {
ui_print "- Searching conflicting XML"
for MX in $MOD_XML; do
MOD="$(echo "$MX" | awk -F'/' '{print $5}')"
ui_print "  $MOD: $MX"
STRIP_ENTRY "$MX"
done
}

# Find and patch conflicting XML
PATCH_SX && PATCH_MX

# Additional add-on for check gms status
ADDON() {
ui_print "- Inflating add-on file"
mkdir -p $MODPATH/system/bin
mv -f $MODPATH/gmsc $MODPATH/system/bin/gmsc
}

# Clear old GMS data on first install (should fix delayed incoming messages)
cd /data/data
find . -type f -name '*gms*' -delete
ui_print "- Clearing old GMS data"

FINALIZE() {
ui_print "- Finalizing installation"

# Clean up
 ui_print "  Cleaning obsolete files"
find $MODPATH/* -maxdepth 0 \
! -name 'module.prop' \
! -name 'post-fs-data.sh' \
! -name 'service.sh' \
! -name 'system' \
! -name 'product' \
! -name 'my_product' \
! -name 'vendor' \
! -name 'system_ext' \
! -name 'leanbanner.jpg' \
! -name 'uninstall.sh' \
-exec rm -rf {} \;

# Settings dir and file permission
ui_print "  Settings permissions"
set_perm_recursive $MODPATH 0 0 0755 0755
set_perm $MODPATH/system/bin/gmsc 0 2000 0755
}

# Final adjustment
ADDON && FINALIZE
