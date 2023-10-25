import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';

class AppIconButton extends AppState {
  const AppIconButton({
    super.key,
    required this.id,
    required this.icon,
    this.onPressed,
  });

  final String id;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return SizedBox(
      height: 48,
      width: 48,
      child: Material(
        type: MaterialType.transparency,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed != null
              ? () {
                  onPressed!.call();
                  analytics.logButtonPressed(id);
                }
              : null,
          child: Icon(icon),
        ),
      ),
    );
  }
}
