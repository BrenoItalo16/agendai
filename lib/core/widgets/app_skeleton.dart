import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({super.key, this.width, this.child});

  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Shimmer.fromColors(
      baseColor: t.grey.withOpacity(0.3),
      highlightColor: t.white,
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
