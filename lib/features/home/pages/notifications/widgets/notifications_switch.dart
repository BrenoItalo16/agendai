import 'package:agendai/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';

class NotificationsSwitch extends AppStateless {
  const NotificationsSwitch({
    super.key,
    required this.showRead,
    required this.onChanged,
  });

  final bool showRead;
  final Function(bool) onChanged;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 48,
      decoration: BoxDecoration(
        color: theme.lightGrey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Stack(
            children: [
              AnimatedAlign(
                alignment:
                    showRead ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  width: constraints.maxWidth / 2,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: theme.black.withOpacity(0.1),
                          blurRadius: 40,
                          offset: const Offset(0, 16)),
                    ],
                    color: theme.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
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
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Text(
                          'Não lidas',
                          style: theme.body16Bold.copyWith(
                            color: showRead ? theme.grey : theme.txtColor,
                          ),
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
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Text(
                          'Lidas',
                          style: theme.body16Bold.copyWith(
                            color: showRead ? theme.txtColor : theme.grey,
                          ),
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
