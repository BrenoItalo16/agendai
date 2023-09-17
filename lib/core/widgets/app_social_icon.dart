// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AppSocialIcon extends StatelessWidget {
  const AppSocialIcon({
    Key? key,
    required this.iconPath,
    required this.onPressed,
  }) : super(key: key);

  final String iconPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Material(
      type: MaterialType.transparency,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        highlightColor: t.primary.withOpacity(0.2),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 32,
            width: 32,
            child: SvgPicture.asset(iconPath),
          ),
        ),
      ),
    );
  }
}
