#!/system/bin/sh

#
# Universal GMS Doze by the
# open-source loving GL-DP and all contributors;
# Patches Google Play services app and certain processes/services to be able to use battery optimization
#

# GMS components
GMS="com.google.android.gms"
VND="com.android.vending"
GC1="auth.managed.admin.DeviceAdminReceiver"
GC2="mdm.receivers.MdmDeviceAdminReceiver"
NLL="/dev/null"

# Enable collective device administrators
for U in $(ls /data/user); do
for C in $GC1 $GC2; do
pm enable --user $U "$GMS/$GMS.$C" > "$NLL" 2>&1
done
done

# Remove GMS and Google Play Store from battery optimization
dumpsys deviceidle whitelist +$GMS > "$NLL" 2>&1
dumpsys deviceidle whitelist +$VND > "$NLL" 2>&1

#Play Store
am set-standby-bucket com.android.vending active
cmd appops set com.android.vending RUN_IN_BACKGROUND allow
cmd appops set com.android.vending RUN_ANY_IN_BACKGROUND allow
#am force-stop com.android.vending >/dev/null 2>&1

#gms disable
pm enable com.google.android.gms/com.google.android.gms.ads.identifier.service.AdvertisingIdNotificationService
pm enable com.google.android.gms/com.google.android.gms.ads.identifier.service.AdvertisingIdService
pm enable com.google.android.gms/com.google.android.gms.ads.AdRequestBrokerService
pm enable com.google.android.gms/com.google.android.gms.ads.settings.AdsSettingsActivityService
pm enable com.google.android.gms/com.google.android.gms.ads.GservicesValueBrokerService
pm enable com.google.android.gms/com.google.android.gms.ads.jams.NegotiationService
pm enable com.google.android.gms/com.google.android.gms.ads.MobileAdsSettingManagerService
pm enable com.google.android.gms/com.google.android.gms.ads.measurement.GmpConversionTrackingBrokerService
pm enable com.google.android.gms/com.google.android.gms.ads.cache.CacheBrokerService
pm enable com.google.android.gms/com.google.android.gms.ads.config.FlagsReceiver
pm enable com.google.android.gms/com.google.android.gms.ads.social.GcmSchedulerWakeupService
pm enable com.google.android.gms/com.google.android.gms.adsidentity.service.AdServicesExtDataStorageService
pm enable com.google.android.gms/com.google.android.gms.nearby.mediums.nearfieldcommunication.NfcAdvertisingService
pm enable com.google.android.gms/com.google.android.gms.analytics.AnalyticsService
pm enable com.google.android.gms/com.google.android.gms.analytics.AnalyticsTaskService
pm enable com.google.android.gms/com.google.android.gms.analytics.internal.PlayLogReportingService
pm enable com.google.android.gms/com.google.android.gms.analytics.service.AnalyticsService
pm enable com.google.android.gms/com.google.android.gms.analytics.AnalyticsReceiver
pm enable com.google.android.gms/com.google.android.gms.stats.eastworld.EastworldService
pm enable com.google.android.gms/com.google.android.gms.stats.service.DropBoxEntryAddedService
pm enable com.google.android.gms/com.google.android.gms.stats.service.DropBoxEntryAddedReceiver
pm enable com.google.android.gms/com.google.android.gms.stats.DropBoxEntryAddedService
pm enable com.google.android.gms/com.google.android.gms.stats.PlatformStatsCollectorService
pm enable com.google.android.gms/com.google.android.gms.common.stats.GmsCoreStatsService
pm enable com.google.android.gms/com.google.android.gms.common.stats.StatsUploadService
pm enable com.google.android.gms/com.google.android.gms.common.stats.net.NetworkReportService
pm enable com.google.android.gms/com.google.android.gms.tron.CollectionService
pm enable com.google.android.gms/com.google.android.gms.tron.AlarmReceiver
pm enable com.google.android.gms/com.google.android.gms.feedback.FeedbackAsyncService
pm enable com.google.android.gms/com.google.android.gms.feedback.LegacyBugReportService
pm enable com.google.android.gms/com.google.android.gms.feedback.OfflineReportSendTaskService
pm enable com.google.android.gms/com.google.android.gms.googlehelp.metrics.ReportBatchedMetricsGcmTaskService
pm enable com.google.android.gms/com.google.android.gms.presencemanager.service.PresenceManagerPresenceReportService
pm enable com.google.android.gms/com.google.android.gms.usagereporting.service.UsageReportingIntentService
pm enable com.google.android.gms/com.google.android.gms.crash.service.CrashReportService
pm enable com.google.android.gms/com.google.android.gms.clearcut.service.ClearcutLoggerService
pm enable com.google.android.gms/com.google.android.gms.clearcut.debug.ClearcutDebugDumpService
pm enable com.google.android.gms/com.google.android.gms.measurement.AppMeasurementService
pm enable com.google.android.gms/com.google.android.gms.measurement.AppMeasurementJobService
pm enable com.google.android.gms/com.google.android.gms.measurement.AppMeasurementReceiver
pm enable com.google.android.gms/com.google.android.gms.measurement.PackageMeasurementReceiver
pm enable com.google.android.gms/com.google.android.gms.romanesco.ContactsLoggerUploadService
pm enable com.google.android.gms/com.google.android.gms.backup.stats.BackupStatsService
pm enable com.google.android.gms/com.google.android.gms.backup.component.FullBackupJobLoggerService
pm enable com.google.android.gms/com.google.android.gms.enpromo.PromoInternalPersistentService
pm enable com.google.android.gms/com.google.android.gms.enpromo.PromoInternalService
pm enable com.google.android.gms/com.google.android.gms.nearby.messages.debug.DebugPokeService
pm enable com.google.android.gms/com.google.android.gms.chimera.container.logger.ExternalDebugLoggerService
pm enable com.google.android.gms/com.google.android.gms.common.appdoctor.LocalAppDoctorReceiver
pm enable com.google.android.gms/com.google.android.gms.udc.gcm.GcmBroadcastReceiver
pm enable com.google.android.gms/com.google.android.gms.magictether.logging.DailyMetricsLoggerService
pm enable com.google.android.gms/com.google.android.gms.herrevad.service.HerrevadAndroidService
pm enable com.google.android.gms/com.google.android.gms.focus.FocusAndroidService
pm enable com.google.mainline.telemetry/com.google.mainline.telemetry.TelemetryService
pm enable com.google.android.gms/com.google.android.gms.instantapps.service.InstantAppsService
pm enable com.google.android.gms/com.google.android.gms.checkin.EventLogService
pm enable com.google.android.gms/com.google.android.gms.location.reporting.service.GcmBroadcastReceiver
pm enable com.google.android.gms/.ads.AdRequestBrokerService
pm enable com.google.android.gms/.ads.identifier.service.AdvertisingIdService
pm enable com.google.android.gms/.ads.measurement.GmpConversionTrackingBrokerService
pm enable com.google.android.gms/.analytics.AnalyticsService
pm enable com.google.android.gms/.analytics.AnalyticsTaskService
pm enable com.google.android.gms/.analytics.internal.PlayLogReportingService
pm enable com.google.android.gms/.analytics.service.AnalyticsService
pm enable com.google.android.gms/.checkin.EventLogService
pm enable com.google.android.gms/.clearcut.debug.ClearcutDebugDumpService
pm enable com.google.android.gms/.common.stats.GmsCoreStatsService
pm enable com.google.android.gms/.common.stats.StatsUploadService
pm enable com.google.android.gms/.feedback.LegacyBugReportService
pm enable com.google.android.gms/.measurement.AppMeasurementJobService
pm enable com.google.android.gms/.measurement.AppMeasurementService
pm enable com.google.android.gms/.measurement.service.MeasurementBrokerService
pm enable com.google.android.gms/.stats.PlatformStatsCollectorService
pm enable com.google.android.gms/.stats.eastworld.EastworldService
pm enable com.google.android.gms/.tron.CollectionService
pm enable com.google.android.gms/.usagereporting.service.UsageReportingIntentService
pm enable com.android.vending/com.google.android.finsky.enterprisedevicereport.AppStatesService
pm enable com.android.webview/org.chromium.android_webview.services.MetricsBridgeService
pm enable com.android.webview/org.chromium.android_webview.services.MetricsUploadService
pm enable com.google.android.gms/.chimera.GmsIntentOperationService
pm enable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver

# Remove all module files after un-installation
rm -rf /data/adb/universal-gms-doze

exit 0
