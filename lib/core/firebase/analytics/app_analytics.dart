import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalytics {
  AppAnalytics(this._analytics);

  final FirebaseAnalytics _analytics;

  Future<void> logButtonPressed(String id) {
    return _analytics.logEvent(
      name: 'button_pressed',
      parameters: {'id': id},
    );
  }

  Future<void> setUserId(String? id) {
    return _analytics.setUserId(id: id);
  }

  Future<void> logFieldEdited(String id) {
    return _analytics.logEvent(
      name: 'field_edited',
      parameters: {'id': id},
    );
  }
}
