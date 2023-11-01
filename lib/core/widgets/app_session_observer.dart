import 'package:agendai/features/auth/data/session/cubit/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSessionObserver extends StatefulWidget {
  const AppSessionObserver({
    super.key,
    this.child,
    this.listener,
    this.builder,
  });

  final Widget? child;
  final Function(SessionState)? listener;
  final Widget Function(BuildContext, SessionState)? builder;

  @override
  State<AppSessionObserver> createState() => _AppSessionObserverState();
}

class _AppSessionObserverState extends State<AppSessionObserver> {
  @override
  void initState() {
    super.initState();

    final SessionCubit sessionCubit = context.read();
    widget.listener?.call(sessionCubit.state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionCubit, SessionState>(
      listener: (context, state) {
        widget.listener?.call(state);
      },
      builder: widget.builder ?? (context, state) => widget.child!,
    );
  }
}
