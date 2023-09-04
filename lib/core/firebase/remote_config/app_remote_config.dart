import 'package:firebase_remote_config/firebase_remote_config.dart';

enum AppRemoteConfigKeys {
  appMinVersion('app_min_version', 1),

  instagramUrl('instagram_url', 'https://instagram.com/'),

  maintenance('maintenance', false);

  const AppRemoteConfigKeys(this.key, this.defaultValue);

  final String key;
  final dynamic defaultValue;
}

class AppRemoteConfig {
  AppRemoteConfig(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
    await _remoteConfig.setDefaults({
      AppRemoteConfigKeys.appMinVersion.key:
          AppRemoteConfigKeys.appMinVersion.defaultValue,
      AppRemoteConfigKeys.maintenance.key:
          AppRemoteConfigKeys.maintenance.defaultValue,
      AppRemoteConfigKeys.instagramUrl.key:
          AppRemoteConfigKeys.instagramUrl.defaultValue,
    });

    await _remoteConfig.fetchAndActivate();

    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
    });
  }

  int get appMinVersion =>
      _remoteConfig.getInt(AppRemoteConfigKeys.appMinVersion.key);

  bool get isMaintenance =>
      _remoteConfig.getBool(AppRemoteConfigKeys.maintenance.key);

  String get instagramUrl =>
      _remoteConfig.getString(AppRemoteConfigKeys.instagramUrl.key);
}
