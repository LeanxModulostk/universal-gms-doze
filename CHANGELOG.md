## Change Log:
- 1.9.4   
Google Play Store (com.android.vending) now gets the same treatment as Google Play services   
XML patching also removes allow-in-power-save-except-idle for Play Store (it kept the app in the exempted standby bucket)   
Play Store is removed from the battery optimization whitelist on boot and checked by gmsc   
Play Store restricted on boot (standby bucket, RUN_IN_BACKGROUND, RUN_ANY_IN_BACKGROUND, force-stop)   
Disabled GMS / Play Store / WebView telemetry, ads, analytics and crash reporting components on boot (re-enabled on uninstall)   
Added action button (credits and support channel)   
gmsc now prints the matching whitelist line when an app is Not Optimized   
Fixed uninstaller script (stray parenthesis stopped it before cleanup) and it is now kept in the final module   
Uninstaller restores everything the module changed   
Reworked XML patching into reusable functions   
Portable output redirection in boot and uninstall scripts   
Disabled the /my_product bind mount in post-fs-data.sh   

- 1.9.3   
Added /my_product support (patched sysconfig bind-mounted over the original)   

- 1.9.2   
Android 15 support   
Improved root implementations (Support Magisk / KernelSU / APatch)   
Improved XML dir/path detections (73Sydney)   
Clear old GMS data on first install   

- 1.9.1   
Improved installation (Magisk Live and KernelSU)   
Fixed root method detections   
Fixed uninstaller script   

- 1.9.0   
Android 14 support      
Fixed synchronization for Location Sharing and Play Games   

- 1.8.8   
A long-awaited hotfix   
Addresses script that caused patching XML gone wrong   
Raised Magisk Boot Service to 100 seconds   

- 1.8.7   
Android 13 support   
Added GMS to battery optimization and disabled another components   
Fixed broken API checking and Multi-User support   
Moved to inbuilt (Magisk) BusyBox   
Improved pre-boot conflict fixer and proper boot script execution   
Improved superuser checking method and used cmd flag arguments   
Improved XML patching logic   
Minimized root path checking depth   
Revived overall code quality and syntax   
Rewrite GMS state checker bin   

- 1.8.6   
Added /system_ext detection support   
Improved patching detections (Allow to revoke location permissions)   

- 1.8.5   
Added updateJson support   
Improved patching detections (XML files)   

- 1.8.4   
Removed redundant script (GMS: Stay with disabling Find My Device only)   

- 1.8.3   
Android 12 support   
Additional boot complete check   
Multi-User support   
Set ignore for GMS and IMS WRITE_SETTINGS   
Minor improvements   

- 1.8.2   
Android 11 support   
Improved installation (Magisk Live and Custom Recovery)   
Improved patching detections (XML files and conflicting modules)   
Integrated add-on (run 'gmsc' with superuser rights for check optimization status)   
Set ignore for GMS and IMS BOOT_COMPLETED   
Set ignore for GMS and IMS AUTO_START (custom permissions for Oxygen OS)   
Updated template   

- 1.8.1   
Integrated custom recovery installation   
Added boot logic for search and patch any conflicting modules (if present)   
Whitelisted IMS and Turbo (this should fixed location crash issue in MIUI)   

- 1.8.0   
Initial re-release   
100 seconds Magisk Boot Service   
