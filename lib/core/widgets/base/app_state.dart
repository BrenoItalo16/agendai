import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/firebase/analytics/app_analytics.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppState extends StatelessWidget {
  const AppState({super.key});

  Widget builder(BuildContext context, AppTheme theme);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return builder(context, theme);
  }

  AppAnalytics get analytics => getIt<AppAnalytics>();
}
