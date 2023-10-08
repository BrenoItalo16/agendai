import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/features/auth/data/session/cubit/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: BlocBuilder<SessionCubit, SessionState>(
            builder: (context, state) {
              return Text(
                'Olá, ${state.loggedUser?.fullname ?? 'visitante'}',
                style: t.heading20Bold,
              );
            },
          ),
        ),
      ),
    );
  }
}
