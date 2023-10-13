import 'package:agendai/core/widgets/app_skeleton.dart';
import 'package:agendai/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:iconly/iconly.dart';

class AppLoadingRatings extends AppStateless {
  const AppLoadingRatings({super.key});

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return AppSkeleton(
      width: double.maxFinite,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 16,
            width: 80,
            color: Colors.white,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4, bottom: 10),
            child: Row(
              children: [
                Icon(IconlyBold.star, size: 18),
                Icon(IconlyBold.star, size: 18),
                Icon(IconlyBold.star, size: 18),
                Icon(IconlyBold.star, size: 18),
                Icon(IconlyBold.star, size: 18),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              height: 16,
              width: double.maxFinite,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              height: 16,
              width: double.maxFinite,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              height: 16,
              width: 100,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
