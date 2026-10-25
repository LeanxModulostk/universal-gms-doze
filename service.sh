#!/data/adb/magisk/busybox sh
set -o standalone

#
# Universal GMS Doze by the
# open-source loving GL-DP and all contributors;
# Patches Google Play services app and certain processes/services to be able to use battery optimization
#

(
# Wait until boot completed
until [ $(resetprop sys.boot_completed) -eq 1 ] &&
[ -d /sdcard ]; do
sleep 100
done

# GMS components
GMS="com.google.android.gms"
VND="com.android.vending"
GC1="auth.managed.admin.DeviceAdminReceiver"
GC2="mdm.receivers.MdmDeviceAdminReceiver"
NLL="/dev/null"

# Disable collective device administrators
for U in $(ls /data/user); do
for C in $GC1 $GC2; do
pm disable --user $U "$GMS/$GMS.$C" > "$NLL" 2>&1
done
done

# Add GMS and Google Play Store to battery optimization
dumpsys deviceidle whitelist -$GMS > "$NLL" 2>&1
dumpsys deviceidle whitelist -$VND > "$NLL" 2>&1

#Play Store
am set-standby-bucket com.android.vending restricted
cmd appops set com.android.vending RUN_IN_BACKGROUND ignore
cmd appops set com.android.vending RUN_ANY_IN_BACKGROUND ignore
am force-stop com.android.vending >/dev/null 2>&1

#gms disable
pm disable com.google.android.gms/com.google.android.gms.ads.identifier.service.AdvertisingIdNotificationService
pm disable com.google.android.gms/com.google.android.gms.ads.identifier.service.AdvertisingIdService
pm disable com.google.android.gms/com.google.android.gms.ads.AdRequestBrokerService
pm disable com.google.android.gms/com.google.android.gms.ads.settings.AdsSettingsActivityService
pm disable com.google.android.gms/com.google.android.gms.ads.GservicesValueBrokerService
pm disable com.google.android.gms/com.google.android.gms.ads.jams.NegotiationService
pm disable com.google.android.gms/com.google.android.gms.ads.MobileAdsSettingManagerService
pm disable com.google.android.gms/com.google.android.gms.ads.measurement.GmpConversionTrackingBrokerService
pm disable com.google.android.gms/com.google.android.gms.ads.cache.CacheBrokerService
pm disable com.google.android.gms/com.google.android.gms.ads.config.FlagsReceiver
pm disable com.google.android.gms/com.google.android.gms.ads.social.GcmSchedulerWakeupService
pm disable com.google.android.gms/com.google.android.gms.adsidentity.service.AdServicesExtDataStorageService
pm disable com.google.android.gms/com.google.android.gms.nearby.mediums.nearfieldcommunication.NfcAdvertisingService
pm disable com.google.android.gms/com.google.android.gms.analytics.AnalyticsService
pm disable com.google.android.gms/com.google.android.gms.analytics.AnalyticsTaskService
pm disable com.google.android.gms/com.google.android.gms.analytics.internal.PlayLogReportingService
pm disable com.google.android.gms/com.google.android.gms.analytics.service.AnalyticsService
pm disable com.google.android.gms/com.google.android.gms.analytics.AnalyticsReceiver
pm disable com.google.android.gms/com.google.android.gms.stats.eastworld.EastworldService
pm disable com.google.android.gms/com.google.android.gms.stats.service.DropBoxEntryAddedService
pm disable com.google.android.gms/com.google.android.gms.stats.service.DropBoxEntryAddedReceiver
pm disable com.google.android.gms/com.google.android.gms.stats.DropBoxEntryAddedService
pm disable com.google.android.gms/com.google.android.gms.stats.PlatformStatsCollectorService
pm disable com.google.android.gms/com.google.android.gms.common.stats.GmsCoreStatsService
pm disable com.google.android.gms/com.google.android.gms.common.stats.StatsUploadService
pm disable com.google.android.gms/com.google.android.gms.common.stats.net.NetworkReportService
pm disable com.google.android.gms/com.google.android.gms.tron.CollectionService
pm disable com.google.android.gms/com.google.android.gms.tron.AlarmReceiver
pm disable com.google.android.gms/com.google.android.gms.feedback.FeedbackAsyncService
pm disable com.google.android.gms/com.google.android.gms.feedback.LegacyBugReportService
pm disable com.google.android.gms/com.google.android.gms.feedback.OfflineReportSendTaskService
pm disable com.google.android.gms/com.google.android.gms.googlehelp.metrics.ReportBatchedMetricsGcmTaskService
pm disable com.google.android.gms/com.google.android.gms.presencemanager.service.PresenceManagerPresenceReportService
pm disable com.google.android.gms/com.google.android.gms.usagereporting.service.UsageReportingIntentService
pm disable com.google.android.gms/com.google.android.gms.crash.service.CrashReportService
pm disable com.google.android.gms/com.google.android.gms.clearcut.service.ClearcutLoggerService
pm disable com.google.android.gms/com.google.android.gms.clearcut.debug.ClearcutDebugDumpService
pm disable com.google.android.gms/com.google.android.gms.measurement.AppMeasurementService
pm disable com.google.android.gms/com.google.android.gms.measurement.AppMeasurementJobService
pm disable com.google.android.gms/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.google.android.gms/com.google.android.gms.measurement.PackageMeasurementReceiver
pm disable com.google.android.gms/com.google.android.gms.romanesco.ContactsLoggerUploadService
pm disable com.google.android.gms/com.google.android.gms.backup.stats.BackupStatsService
pm disable com.google.android.gms/com.google.android.gms.backup.component.FullBackupJobLoggerService
pm disable com.google.android.gms/com.google.android.gms.enpromo.PromoInternalPersistentService
pm disable com.google.android.gms/com.google.android.gms.enpromo.PromoInternalService
pm disable com.google.android.gms/com.google.android.gms.nearby.messages.debug.DebugPokeService
pm disable com.google.android.gms/com.google.android.gms.chimera.container.logger.ExternalDebugLoggerService
pm disable com.google.android.gms/com.google.android.gms.common.appdoctor.LocalAppDoctorReceiver
pm disable com.google.android.gms/com.google.android.gms.udc.gcm.GcmBroadcastReceiver
pm disable com.google.android.gms/com.google.android.gms.magictether.logging.DailyMetricsLoggerService
pm disable com.google.android.gms/com.google.android.gms.herrevad.service.HerrevadAndroidService
pm disable com.google.android.gms/com.google.android.gms.focus.FocusAndroidService
pm disable com.google.mainline.telemetry/com.google.mainline.telemetry.TelemetryService
pm disable com.google.android.gms/com.google.android.gms.instantapps.service.InstantAppsService
pm disable com.google.android.gms/com.google.android.gms.checkin.EventLogService
pm disable com.google.android.gms/com.google.android.gms.location.reporting.service.GcmBroadcastReceiver
pm disable com.google.android.gms/.ads.AdRequestBrokerService
pm disable com.google.android.gms/.ads.identifier.service.AdvertisingIdService
pm disable com.google.android.gms/.ads.measurement.GmpConversionTrackingBrokerService
pm disable com.google.android.gms/.analytics.AnalyticsService
pm disable com.google.android.gms/.analytics.AnalyticsTaskService
pm disable com.google.android.gms/.analytics.internal.PlayLogReportingService
pm disable com.google.android.gms/.analytics.service.AnalyticsService
pm disable com.google.android.gms/.checkin.EventLogService
pm disable com.google.android.gms/.clearcut.debug.ClearcutDebugDumpService
pm disable com.google.android.gms/.common.stats.GmsCoreStatsService
pm disable com.google.android.gms/.common.stats.StatsUploadService
pm disable com.google.android.gms/.feedback.LegacyBugReportService
pm disable com.google.android.gms/.measurement.AppMeasurementJobService
pm disable com.google.android.gms/.measurement.AppMeasurementService
pm disable com.google.android.gms/.measurement.service.MeasurementBrokerService
pm disable com.google.android.gms/.stats.PlatformStatsCollectorService
pm disable com.google.android.gms/.stats.eastworld.EastworldService
pm disable com.google.android.gms/.tron.CollectionService
pm disable com.google.android.gms/.usagereporting.service.UsageReportingIntentService
pm disable com.android.vending/com.google.android.finsky.enterprisedevicereport.AppStatesService
pm disable com.android.webview/org.chromium.android_webview.services.MetricsBridgeService
pm disable com.android.webview/org.chromium.android_webview.services.MetricsUploadService
pm disable com.google.android.gms/.chimera.GmsIntentOperationService
pm disable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver

exit 0
)
