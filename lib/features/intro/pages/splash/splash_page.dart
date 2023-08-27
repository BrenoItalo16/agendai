import '../../../../core/route/app_routes.dart';
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
    return BlocProvider.value(
      value: cubit,
      child: const Scaffold(
        body: Center(
          //? Splash rive
          child: RiveAnimation.asset('assets/rive/logo_entering.riv'),
        ),
      ),
    );
  }

  @override
  void navToForceUpdate() {
    context.go('/force-update');
  }

  @override
  void navToMaintenance() {
    context.go('/maintenance');
  }

  @override
  void navToOnboarding() {
    context.go(AppRoutes.onboarding);
  }

  @override
  void navToAuth() {
    context.go('/auth');
  }

  @override
  void navToHome() {
    context.go('/home');
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }
}
