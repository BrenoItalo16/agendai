import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter_svg/svg.dart';

class AppEmptyStateIndicator extends AppState {
  const AppEmptyStateIndicator({
    required this.urlImage,
    required this.title,
    required this.message,
    super.key,
  });

  final String urlImage;
  final String title;
  final String message;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: SizedBox(
                  height: 320,
                  child: SvgPicture.asset(
                    urlImage,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: theme.txtColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.txtColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
