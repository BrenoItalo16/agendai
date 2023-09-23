import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, this.onPressed, required this.child, this.width});

  final VoidCallback? onPressed;
  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      width: width,
      // height: 120,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: t.shadow.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(8, 16), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: t.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          highlightColor: t.primary.withOpacity(0.1),
          splashColor: t.primary.withOpacity(0.1),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }
}
