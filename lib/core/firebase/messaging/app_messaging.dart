import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AppMessaging {
  AppMessaging(this._messaging) {
    _configureMessaging();
  }

  final FirebaseMessaging _messaging;

  Future<void> _configureMessaging() async {
    final settings = await _messaging.getNotificationSettings();
    print(settings.authorizationStatus);

    final result = await _messaging.requestPermission();
    print(result.authorizationStatus);

    final token = await _messaging.getToken();
    print('O TOKEN É: $token');

    //? Para uso em primeiro plano
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Navegar para ${message.data["page"]}');
    });

    // final message = await _messaging.getInitialMessage();

    _messaging.onTokenRefresh.listen((event) {});
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('Handling a background message: ${message.notification?.title}');
}
