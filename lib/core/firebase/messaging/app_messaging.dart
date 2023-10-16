import 'dart:convert';

import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/features/home/pages/home/data/notifications_repository.dart';
import 'package:agendai/features/home/pages/home/models/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

enum AppMessagingStatus { denied, allowed, notDetermined }

class AppMessaging {
  AppMessaging(
    this._messaging,
    this._repository,
  );

  final FirebaseMessaging _messaging;
  final NotificationsRepository _repository;

  Future<AppMessagingStatus> checkStatus() async {
    final settings = await _messaging.getNotificationSettings();
    return settings.authorizationStatus.toApp();
  }

  Future<AppMessagingStatus> requestPermission() async {
    final settings = await _messaging.requestPermission();
    return settings.authorizationStatus.toApp();
  }

  Future<void> configure() async {
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      final notification = Notification.fromJson(
        jsonDecode(remoteMessage.data['notification']),
      );
      _repository.markNotificationRead(notification.id);
      router.push(notification.page);
    });
  }

  Future<Notification?> getInitialMessage() async {
    final remoteMessage = await _messaging.getInitialMessage();
    if (remoteMessage != null) {
      final notification = Notification.fromJson(
        jsonDecode(remoteMessage.data['notification']),
      );
      _repository.markNotificationRead(notification.id);
      return notification;
    } else {
      return null;
    }
  }

  Future<String?> getToken() async {
    final status = await checkStatus();
    if (status == AppMessagingStatus.allowed) {
      final token = await _messaging.getToken();
      return token;
    } else {
      return null;
    }
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
