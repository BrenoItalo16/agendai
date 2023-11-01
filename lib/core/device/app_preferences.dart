import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

// enum AppSecureStorageKeys { sessionToken }

enum AppPreferencesKeys { onboardingDone, deviceId }

class AppPreferences {
  AppPreferences(this._preferences);

  final SharedPreferences _preferences;

  bool get shouldShowOnboarding =>
      !(_preferences.getBool(AppPreferencesKeys.onboardingDone.name) ?? false);

  void setOnboardingDone() {
    _preferences.setBool(AppPreferencesKeys.onboardingDone.name, true);
  }

  String get deviceId {
    if (_preferences.containsKey(AppPreferencesKeys.deviceId.name)) {
      return _preferences.getString(AppPreferencesKeys.deviceId.name)!;
    } else {
      final uuid = const Uuid().v4();
      _preferences.setString(AppPreferencesKeys.deviceId.name, uuid);
      return uuid;
    }
  }
}
