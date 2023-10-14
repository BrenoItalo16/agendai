import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/base/app_stateless.dart';

class Glassmorphism extends AppStateless {
  const Glassmorphism({
    super.key,
    this.blur = 2,
    this.opacity = 0.3,
    required this.child,
  });

  final double blur;
  final double opacity;
  final Widget child;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.white.withOpacity(opacity),
                theme.white.withOpacity(opacity),
              ],
            ),
            color: Colors.white.withOpacity(opacity),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(36),
            ),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
