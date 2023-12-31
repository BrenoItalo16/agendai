import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    this.color,
    this.onPressed,
    required this.child,
    this.width,
    this.shadowOffset = const Offset(6, 12),
    this.borderRadius,
    this.padding = const EdgeInsets.all(20),
    this.shadowEnabled = true,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final Offset shadowOffset;
  final BorderRadius? borderRadius;
  final EdgeInsets padding;
  final bool shadowEnabled;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: shadowEnabled ? shadowOffset.dy * 2 : 0),
      decoration: BoxDecoration(
        boxShadow: [
          if (shadowEnabled)
            BoxShadow(
              offset: shadowOffset,
              blurRadius: 15,
              spreadRadius: 0,
              color: t.black.withOpacity(0.08),
            )
        ],
      ),
      child: Material(
        color: color ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(18),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          highlightColor: t.primary.withOpacity(0.1),
          splashColor: t.primary.withOpacity(0.1),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
