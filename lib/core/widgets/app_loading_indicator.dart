import 'package:agendai/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoadingIndicator extends AppStateless {
  const AppLoadingIndicator({
    super.key,
    this.size = 40,
  });

  final double size;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: theme.primary,
      size: size,
    );
  }
}
