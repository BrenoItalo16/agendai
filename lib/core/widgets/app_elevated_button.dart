import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends AppState {
  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    required this.id,
  });

  final String id;
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return ElevatedButton(
      onPressed: onPressed != null
          ? () {
              onPressed!.call();
              analytics.logButtonPressed(id);
            }
          : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return theme.grey;
          }
          return theme.primary;
        }),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        minimumSize: MaterialStateProperty.all(const Size(128, 58)),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        foregroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return theme.lightGrey;
          }
          return Colors.white;
        }),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.transparent,
          ),
          Flexible(
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Icon(icon),
        ],
      ),
    );
  }
}
