import 'package:agendai/core/device/app_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage {
  AppSecureStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> getSessionToken() {
    return _secureStorage.read(key: AppSecureStorageKeys.sessionToken.name);
  }

  Future<void> saveSessionToken(String token) {
    return _secureStorage.write(
      key: AppSecureStorageKeys.sessionToken.name,
      value: token,
    );
  }
}
