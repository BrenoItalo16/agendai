import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppSkeleton extends AppStateless {
  const AppSkeleton({super.key, this.width, this.child});

  final double? width;
  final Widget? child;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Shimmer.fromColors(
      baseColor: theme.grey.withOpacity(0.3),
      highlightColor: theme.white,
      child: child ??
          Container(
            width: width,
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.amberAccent,
            ),
          ),
    );
  }
}
