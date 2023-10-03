import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppOutlinedButton extends StatefulWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.minHeight = 56,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double minHeight;

  @override
  State<AppOutlinedButton> createState() => _AppOutlinedButtonState();
}

class _AppOutlinedButtonState extends State<AppOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    AppTheme t = context.watch();

    return OutlinedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          side: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return BorderSide(color: t.lightGrey);
            }
            return BorderSide(color: t.primary, width: 2);
          }),
          minimumSize: MaterialStateProperty.all(Size(128, widget.minHeight)),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          foregroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return t.lightGrey;
            }
            return t.primary;
          }),
          // elevation: MaterialStateProperty.all(2),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20))),
      child: Row(
        children: [
          const SizedBox(width: 24),
          Center(
            child: Text(
              widget.label,
            ),
          ),
          Icon(
            widget.icon,
          ),
        ],
      ),
    );
  }
}
