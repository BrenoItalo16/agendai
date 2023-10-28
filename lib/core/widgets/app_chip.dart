import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';

class AppChip extends AppState {
  const AppChip({
    super.key,
    required this.text,
    this.minWidth,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 4,
    ),
  });

  final String text;
  final double? minWidth;
  final TextStyle? textStyle;
  final EdgeInsets padding;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Container(
      constraints:
          minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: theme.lightGrey,
      ),
      padding: padding,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle ?? theme.label12Bold.copyWith(color: theme.primary),
      ),
    );
  }
}


// class AppChip extends AppState {
//   const AppChip({
//     super.key,
//     required this.text,
//     this.minWidth,
//     this.textStyle,
//     this.color,
//   });

//   final String text;
//   final double? minWidth;
//   final TextStyle? textStyle;
//   final Color? color;

//   @override
//   Widget builder(BuildContext context, AppTheme theme) {
//     return Container(
//       constraints:
//           minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(6),
//         color: color ?? theme.lightGrey,
//       ),
//       padding: const EdgeInsets.symmetric(
//         vertical: 4,
//         horizontal: 10,
//       ),
//       child: Text(text,
//           textAlign: TextAlign.center,
//           style: textStyle ?? theme.label12.copyWith(color: theme.txtColor)),
//     );
//   }
// }
