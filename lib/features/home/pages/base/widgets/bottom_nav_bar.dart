import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:iconly/iconly.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.page,
    required this.onChanged,
  });

  final int page;
  final Function(int) onChanged;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _topAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _bottomAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    final appWidth = MediaQuery.sizeOf(context).width;
    final w = (appWidth - (5 * 56)) / 6;
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 82,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 6),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(36),
                ),
              ),
              child: Stack(
                children: [
                  //?Começa aqui
                  Positioned(
                    bottom: -36,
                    child: GlassmorphicContainer(
                      width: appWidth,
                      height: 112,
                      borderRadius: 36,
                      blur: 8,
                      border: 2,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.white.withOpacity(0.4),
                          theme.white.withOpacity(0.4),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.white,
                          theme.white,
                        ],
                      ),
                    ),
                  ),

                  //!Termina aqui
                  AnimatedPositioned(
                    top: 10,
                    left: w * (widget.page + 1) + widget.page * 56,
                    duration: const Duration(milliseconds: 250),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.elasticInOut,
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: widget.page != 2
                            ? theme.primary.withOpacity(0.18)
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < 5; i++)
                          GestureDetector(
                            onTap: i != 2
                                ? () {
                                    widget.onChanged(i);
                                  }
                                : null,
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Icon(
                                [
                                  IconlyLight.home,
                                  IconlyLight.calendar,
                                  IconlyLight.add_user,
                                  IconlyLight.notification,
                                  IconlyLight.profile,
                                ][i],
                                color: widget.page == i
                                    ? theme.primary
                                    : theme.black,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  widget.onChanged(2);
                },
                child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          gradient: LinearGradient(
                            colors: widget.page == 2
                                ? [
                                    theme.secondary,
                                    theme.primary,
                                  ]
                                : [
                                    theme.primary,
                                    theme.primary,
                                  ],
                            begin: _topAlignmentAnimation.value,
                            end: _bottomAlignmentAnimation.value,
                          ),
                        ),
                        child: Icon(
                          IconlyLight.category,
                          color: theme.white,
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
