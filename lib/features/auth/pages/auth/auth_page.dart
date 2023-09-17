import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_divider.dart';
import 'package:agendai/core/widgets/app_elevated_button.dart';
import 'package:agendai/core/widgets/app_logo.dart';
import 'package:agendai/core/widgets/app_outlined_button.dart';
import 'package:agendai/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme t = context.watch();
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppLogo(),
              const SizedBox(height: 32),
              Text(
                "Olá, como deseja acessar?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: t.txtColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),
              AppElevatedButton(
                label: 'Entrar',
                onPressed: () => context.push(AppRoutes.login.fullpath),
              ),
              const SizedBox(height: 24),
              AppOutlinedButton(
                label: 'Cadastrar',
                onPressed: () => context.push(AppRoutes.signup.fullpath),
              ),
              const SizedBox(height: 24),
              const AppDivider(text: 'ou'),
              AppTextButton(
                color: t.primary,
                label: 'Entrar como visitante',
                onPressed: () => context.push(AppRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
