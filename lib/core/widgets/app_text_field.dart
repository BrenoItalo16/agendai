import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.title,
    required this.hint,
    this.initialText,
    required this.onChanged,
    this.textInputType,
    this.obscure = false,
    this.inputFormaters,
    this.error,
  });

  final String title;
  final String hint;
  final String? initialText;
  final Function(String) onChanged;
  final TextInputType? textInputType;
  final bool obscure;
  final List<TextInputFormatter>? inputFormaters;
  final String? error;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    AppTheme t = context.watch();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: t.lightGrey,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 12),
                  child: Row(
                    children: [
                      Text(
                        widget.title,
                        style: t.label12Bold,
                        textAlign: TextAlign.start,
                      ),
                      if (widget.error != null)
                        Expanded(
                          child: Text(
                            (': ${widget.error!}'),
                            style: t.label12.copyWith(color: t.red),
                          ),
                        ),
                    ],
                  ),
                ),
                TextFormField(
                  initialValue: widget.initialText,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    isCollapsed: true,
                    hintText: widget.hint,
                    hintStyle: t.body16.copyWith(color: t.grey),
                  ),
                  style: t.body16,
                  onChanged: widget.onChanged,
                  keyboardType: widget.textInputType,
                  obscureText: widget.obscure && hidePass,
                  inputFormatters: widget.inputFormaters,
                ),
              ],
            ),
          ),
          if (widget.obscure)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: 48,
                width: 48,
                child: Material(
                  type: MaterialType.transparency,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: IconButton(
                    highlightColor: t.primary.withOpacity(0.2),
                    onPressed: () {
                      setState(() {
                        hidePass = !hidePass;
                      });
                    },
                    icon: Icon(
                      hidePass ? IconlyLight.show : IconlyLight.hide,
                      color: t.txtColor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
