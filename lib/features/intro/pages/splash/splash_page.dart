import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'splash_page_actions.dart';
import 'splash_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> implements SplashPageActions {
  late final SplashPageCubit cubit = SplashPageCubit(this);

  @override //? Call the initialize from cubit
  void initState() {
    super.initState();
    cubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme t = context.watch();
    final appHeight = MediaQuery.of(context).size.height;
    final appWidth = MediaQuery.of(context).size.width;
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: t.white,
        body: Center(
          //? Splash rive
          child: Stack(
            children: [
              const RiveAnimation.asset('assets/rive/animated_logo.riv'),
              Positioned(
                right: 0,
                top: appHeight / 2 - (appWidth / 6) + (appWidth * 0.45),
                child: Container(
                  height: appWidth / 5,
                  width: appWidth / 2.2,
                  color: t.white,
                  // color: AppTheme().white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void navToMaintenance() {
    context.go(AppRoutes.maintenance);
  }

  @override
  void navToOnboarding() {
    context.go(AppRoutes.onboarding);
  }

  @override
  void navToAuth() {
    context.go(AppRoutes.auth);
  }

  @override
  void navToForceUpdate() {
    context.go(AppRoutes.forceUpdate);
  }

  @override
  void navToHome() {
    context.go('/alterar esta rota'); //TODO: Alterar esta rota para "home".
  }

  @override
  void dispose() {
    cubit.dispose();
    cubit.close();
    super.dispose();
  }
}
