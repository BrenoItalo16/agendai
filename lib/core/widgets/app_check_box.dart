import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';

class AppCheckBox extends AppState {
  const AppCheckBox({super.key, required this.checked, required this.onTap});

  final bool checked;
  final VoidCallback? onTap;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: theme.primary,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(2),
        child: checked
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: theme.primary,
                ),
              )
            : null,
      ),
    );
  }
}
