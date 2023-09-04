import 'package:firebase_messaging/firebase_messaging.dart';

enum AppMessagingStatus { denied, allowed, notDetermined }

class AppMessaging {
  AppMessaging(this._messaging);

  final FirebaseMessaging _messaging;

  Future<AppMessagingStatus> checkStatus() async {
    final settings = await _messaging.getNotificationSettings();
    return settings.authorizationStatus.toApp();
  }

  Future<AppMessagingStatus> requestPermission() async {
    final settings = await _messaging.requestPermission();
    return settings.authorizationStatus.toApp();
  }
}

extension AuthorizationStatusX on AuthorizationStatus {
  AppMessagingStatus toApp() {
    switch (this) {
      case AuthorizationStatus.authorized:
      case AuthorizationStatus.provisional:
        return AppMessagingStatus.allowed;
      case AuthorizationStatus.denied:
        return AppMessagingStatus.denied;
      case AuthorizationStatus.notDetermined:
        return AppMessagingStatus.notDetermined;
    }
  }
}
