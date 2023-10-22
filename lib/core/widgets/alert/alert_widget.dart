import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/alert/alert_area_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class AlertWidget extends StatefulWidget {
  const AlertWidget({
    super.key,
    required this.alert,
  });

  final Alert alert;

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(widget.alert.duration).then(
          (value) => _controller.reverse(),
        );
      } else if (status == AnimationStatus.dismissed) {
        getIt<AlertAreaCubit>().removeAlert(widget.alert);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: t.shadow.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: const Offset(2, 10), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              color: switch (widget.alert.type) {
                AlertType.error => t.red,
                AlertType.success => t.green,
                AlertType.notification => t.white,
              },
            ),
            padding: const EdgeInsets.all(24),
            child: InkWell(
              onTap: () {
                widget.alert.onPressed;
                getIt<AlertAreaCubit>().removeAlert(widget.alert);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.alert.title, style: t.body16Bold),
                        if (widget.alert.subtitle != null)
                          Text(widget.alert.subtitle!, style: t.body13),
                      ],
                    ),
                  ),
                  Icon(
                    switch (widget.alert.type) {
                      AlertType.error => IconlyLight.danger,
                      AlertType.success => IconlyLight.tick_square,
                      AlertType.notification => IconlyLight.notification,
                    },
                    color: switch (widget.alert.type) {
                      AlertType.error => t.white,
                      AlertType.success => t.black,
                      AlertType.notification => t.txtColor,
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
