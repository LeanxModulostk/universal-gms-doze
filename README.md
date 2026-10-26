# Universal GMS Doze Plus

![](https://i.ibb.co/DDcNNP3C/1793044189104.png)

## Overview
- Patches Google Play services (GMS) and Google Play Store so both can use battery optimization
- Restricts Play Store background activity and disables GMS / Play Store / WebView telemetry components at boot
- Support API 23 or later
- Support Magisk, KernelSU, and APatch root implementations
- Meta Module (I recommend NoMount)
- Install from the root manager app (installation from recovery is NOT supported) and reboot

## What it does
**At install**
- Searches the system XML files (`/system`, `/system_ext`, `/product`, `/vendor`) and removes the entries that exempt Google Play services and Google Play Store from battery optimization: `allow-in-power-save`, `allow-in-data-usage-save`, `allow-unthrottled-location`, `allow-ignore-location-settings` and OEM whitelist `<wl>` entries. For Google Play Store it also removes `allow-in-power-save-except-idle`.
- Patched copies are placed inside the module (systemless), the original files are not modified.
- Patches the same entries in XML files of other modules under `/data/adb` (also on every boot, before modules are mounted).
- Clears old GMS data (see Troubleshootings).

**On every boot** (`service.sh`)
- Removes both apps from the battery optimization whitelist.
- Disables the device administrator receivers of Google Play services (Find My Device).
- Google Play Store: standby bucket set to `restricted`, `RUN_IN_BACKGROUND` and `RUN_ANY_IN_BACKGROUND` set to `ignore`, and the app is force-stopped.
- Disables GMS, Play Store, WebView and mainline telemetry components (ads, analytics, measurement, crash reporting, stats). The full list is in `service.sh`.

**Add-on**
- `gmsc` (run as root) reports whether Google Play services and Google Play Store are optimized, and prints the matching whitelist line when one is not.

**Action button** (Magisk / KernelSU)
- Shows the module credits, opens the support channel on Telegram and posts a notification. It copies two small images to `/storage/emulated/0/Android/media/` for that notification.

**Uninstall**
- `uninstall.sh` re-enables every component the module disabled, puts both apps back in the battery optimization whitelist and resets the Play Store standby bucket and background permissions.

## Troubleshootings
- Command-line for check optimization (with module installed):
```
> su
> gmsc
```
- Command-line for check optimization (in general):   
There's a line written `Whitelist (except idle) system apps:` and if `com.google.android.gms` or `com.android.vending` line does not exist it means the app is optimized.
```
> su
> dumpsys deviceidle
```
- Command-line for check the Play Store standby bucket:   
`5` means exempted, `45` means restricted. Some ROMs move the app back to the exempted bucket on their own; the background permissions set by the module still apply.
```
> su
> am get-standby-bucket com.android.vending
```
- Command-line for fix delayed incoming messages issue:   
If the issue still persist, move the app to Not Optimized battery usage.   
**Warning:** this deletes every file whose name contains `gms` inside `/data/data`, for all apps and not only Google Play services.
```
> su
> cd /data/data
> find . -type f -name '*gms*' -delete
```
- If something stops working after installing:   
Re-enable the component with `pm enable <package>/<component>` (names are listed in `service.sh`), or uninstall the module to restore everything.
- Command-line for enable Find My Device (optional):   
The module disables it again on the next boot. To keep it enabled, remove the matching lines from `service.sh`.
```
> su
> pm enable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver
```

## Credits
- gloeyisk / module base
- topjohnwu / Magisk - Magisk Module Template
- JumbomanXDA, MrCarb0n / Script fixer and helper
- LeanHijosdesusMadres / Plus build (Google Play Store handling, telemetry components, action button)

## Extras
- Donations: [PayPal](https://www.paypal.me/LeanHijosdesusMadres) - [LiberaPay](https://liberapay.com/LeanHijosdesusMadres) - [Ko-fi](https://ko-fi.com/leantupapi) - [Binance](https://app.binance.com/qr/dplk7b28e9c123ff4e378b472505b0adba63) - [SociaBuzz](https://sociabuzz.com/leanhijosdesusmadres/support) - [More](https://t.me/modulemagiskChiase/4846)
- Source Code: [GitHub](https://github.com/LeanxModulostk/universal-gms-doze)
- Support: [Telegram](https://t.me/modulostk)
