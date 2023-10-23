import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppSkeleton extends AppState {
  const AppSkeleton(
      {super.key, this.width, this.height, this.child, this.margin});

  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsets? margin;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Shimmer.fromColors(
      baseColor: theme.grey.withOpacity(0.3),
      highlightColor: theme.white,
      child: child ??
          Container(
            width: width,
            height: height,
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
          ),
    );
  }
}
