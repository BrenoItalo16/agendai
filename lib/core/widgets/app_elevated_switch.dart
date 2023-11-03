import 'package:flutter/material.dart';

import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/base/app_state.dart';

class AppElevatedSwitch extends AppState {
  const AppElevatedSwitch({
    super.key,
    required this.disabledText,
    required this.enabledText,
    required this.enabled,
    required this.onChanged,
  });

  final String disabledText;
  final String enabledText;
  final bool enabled;
  final Function(bool) onChanged;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: theme.lightGrey,
      ),
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Stack(
            children: [
              AnimatedAlign(
                alignment:
                    enabled ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  width: constraints.maxWidth / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: theme.primary.withOpacity(0.1),
                            blurRadius: 40,
                            offset: const Offset(0, 16))
                      ]),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onChanged(false);
                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          disabledText,
                          style: theme.body13Bold.copyWith(
                              color: enabled ? theme.grey : theme.black),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onChanged(true);
                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          enabledText,
                          style: theme.body13Bold.copyWith(
                              color: !enabled ? theme.grey : theme.txtColor),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
