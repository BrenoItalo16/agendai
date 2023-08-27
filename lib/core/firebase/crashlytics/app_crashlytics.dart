import 'dart:isolate';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class AppCrashlytics {
  AppCrashlytics(this._crashlytics) {
    _configureCrashlytics();
  }

  final FirebaseCrashlytics _crashlytics;

  void _configureCrashlytics() {
    FlutterError.onError = (error) {
      debugPrint('$error');
      _crashlytics.recordFlutterError(error);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlytics.recordError(error, stack, fatal: true);
      return true;
    };

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await _crashlytics.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
        fatal: true,
      );
    }).sendPort);
  }
}
