import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    AppTheme t = context.watch();

    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return t.lightGrey;
          }
          return t.primary;
        }),
        minimumSize: MaterialStateProperty.all(const Size(100, 56)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20),
        ),
        overlayColor: MaterialStateProperty.all(t.primary.withAlpha(64)),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
