import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage {
  AppSecureStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> getSessionToken() {
    return Future.value('r:23eddd12fed9e7f22116e8a33bc66f78');
    // return _secureStorage.read(key: 'sessionToken');
  }
}
