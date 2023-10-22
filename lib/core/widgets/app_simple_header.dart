import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSimpleHeader extends AppStateless {
  const AppSimpleHeader({super.key, required this.title});

  final String title;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    final AppTheme t = context.watch();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: t.heading20Bold,
          ),
        ),
      ),
    );
  }
}
