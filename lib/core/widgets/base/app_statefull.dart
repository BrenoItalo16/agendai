import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppState<T extends StatefulWidget> extends State<T> {
  Widget builder(BuildContext context, AppTheme theme);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();

    return builder(context, theme);
  }
}
