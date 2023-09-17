import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.text = 'ou'});

  final String? text;

  @override
  Widget build(BuildContext context) {
    AppTheme t = context.watch();
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: t.grey,
          ),
        ),
        if (text != null)
          Expanded(
            child: Center(
              child: Text(
                text!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: t.black,
                ),
              ),
            ),
          ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: t.grey,
          ),
        ),
      ],
    );
  }
}
