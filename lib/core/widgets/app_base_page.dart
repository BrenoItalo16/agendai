// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:agendai/core/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'app_icon_button.dart';

enum AppBasePageType { fixed, scroll }

class AppBasePage extends StatefulWidget {
  const AppBasePage({
    Key? key,
    required this.title,
    required this.body,
    this.bodyPadding = const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
    this.isLoading = false,
    this.type = AppBasePageType.scroll,
    this.bottomAction,
    this.backgroundColor,
  }) : super(key: key);

  final String title;
  final Widget body;
  final EdgeInsets bodyPadding;
  final bool isLoading;
  final AppBasePageType type;
  final Widget? bottomAction;
  final Color? backgroundColor;

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
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 3,
    );
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
    final AppTheme t = context.watch();

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Stack(
          children: [
            if (widget.type == AppBasePageType.scroll)
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top + 52,
                  bottom: MediaQuery.paddingOf(context).bottom +
                      (widget.bottomAction != null ? 104 : 0),
                ).add(widget.bodyPadding),
                child: widget.body,
              )
            else
              widget.body,
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
                        alignment: Alignment.center,
                        child: widget.isLoading
                            ? LoadingAnimationWidget.stretchedDots(
                                color: t.primary,
                                size: 60,
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
              child: AppCard(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(36),
                ),
                padding: EdgeInsets.zero,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppIconButton(
                          id: 'back',
                          icon: IconlyBold.arrow_left_2,
                          onPressed: context.pop,
                        ),
                        Expanded(
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: t.body16Bold,
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (widget.bottomAction != null)
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.8),
                        Colors.white.withOpacity(0.8),
                      ],
                      stops: const [0, 0.1, 1],
                    ),
                  ),
                  child: widget.bottomAction,
                ),
              )
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
