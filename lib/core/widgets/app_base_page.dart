// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

import 'package:agendai/core/theme/app_theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'app_icon_button.dart';

class AppBasePage extends StatefulWidget {
  const AppBasePage({
    Key? key,
    required this.title,
    required this.body,
    this.bodyPadding = const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final Widget body;
  final EdgeInsets bodyPadding;
  final bool isLoading;

  @override
  State<AppBasePage> createState() => _AppBasePageState();
}

class _AppBasePageState extends State<AppBasePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 3);
  }

  @override
  void didUpdateWidget(AppBasePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.isLoading && widget.isLoading) {
      controller.forward();
    } else if (oldWidget.isLoading && !widget.isLoading) {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTheme t = context.watch();
    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top +
                    80 +
                    widget.bodyPadding.top,
                bottom: MediaQuery.paddingOf(context).bottom +
                    widget.bodyPadding.bottom,
                left: widget.bodyPadding.left,
                right: widget.bodyPadding.right,
              ),
              child: widget.body,
            ),
            if (widget.isLoading)
              Positioned.fill(
                child: AbsorbPointer(
                  absorbing: widget.isLoading,
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      final value = controller.value;
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
                        child: Container(
                          color: Colors.white.withOpacity(0.2),
                          alignment: Alignment.center,
                          child: widget.isLoading
                              ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: t.primary,
                                  size: 56,
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: t.shadow.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0, 16), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(36),
                  ),
                  color: t.white,
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppIconButton(
                            icon: IconlyBold.arrow_left_2,
                            onPressed: context.pop),
                        Expanded(
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: t.title16Bold,
                          ),
                        ),
                        const SizedBox(width: 44, height: 44),
                      ],
                      //?IconlyBold.arrow_right_2
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}