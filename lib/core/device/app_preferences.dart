import 'package:shared_preferences/shared_preferences.dart';

enum AppSecureStorageKeys { sessionToken }

enum AppPreferencesKeys { onboardingDone }

class AppPreferences {
  AppPreferences(this._preferences);

  final SharedPreferences _preferences;

  bool get shouldShowOnboarding =>
      !(_preferences.getBool(AppPreferencesKeys.onboardingDone.name) ?? false);

  void setOnboardingDone() {
    _preferences.setBool(AppPreferencesKeys.onboardingDone.name, true);
  }
}
