import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/features/auth/data/session/cubit/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: context.read<SessionCubit>().logout,
                    icon: Icon(Icons.menu, color: t.black),
                  ),
                  const SizedBox(width: 8),
                  BlocBuilder<SessionCubit, SessionState>(
                    builder: (context, state) {
                      return Text(
                        'Olá, ${state.loggedUser?.fullname ?? 'visitante'}',
                        style: t.heading20Bold,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
