import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class CustomFirebaseAnalyticsObserver
    extends RouteObserver<ModalRoute<dynamic>> {
  CustomFirebaseAnalyticsObserver({
    required this.analytics,
  });

  final FirebaseAnalytics analytics;

  void _sendScreenView(Route<dynamic> route) {
    final String? screenName = route.settings.name;

    if (screenName != null && route.settings.arguments is Map) {
      analytics.logEvent(
        name: 'screen_view',
        parameters: {
          'screen_name': screenName,
          ...route.settings.arguments as Map
        },
      );
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _sendScreenView(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _sendScreenView(previousRoute);
    }
  }
}
