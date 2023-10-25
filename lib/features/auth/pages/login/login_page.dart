import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_base_page.dart';
import 'package:agendai/core/widgets/app_divider.dart';
import 'package:agendai/core/widgets/app_elevated_button.dart';
import 'package:agendai/core/widgets/app_logo.dart';
import 'package:agendai/core/widgets/app_social_icon.dart';
import 'package:agendai/core/widgets/app_text_field.dart';
import 'package:agendai/features/auth/models/email.dart';
import 'package:agendai/features/auth/models/password.dart';
import 'package:agendai/features/auth/pages/login/login_page_actions.dart';
import 'package:agendai/features/auth/pages/login/login_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({this.redirectTo, super.key});

  final String? redirectTo;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageActions {
  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return BlocProvider(
      create: (context) => LoginPageCubit(this),
      child: BlocBuilder<LoginPageCubit, LoginPageState>(
          builder: (context, state) {
        return AppBasePage(
          title: 'Criar conta',
          isLoading: state.isLoading,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: AppLogo()),
              const SizedBox(height: 16),
              Text(
                'Bem-vindo de volta!',
                style: t.heading36Bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              AppTextField(
                id: 'e-mail',
                title: 'E-mail',
                hint: 'Ex: nome@email.com',
                textInputType: TextInputType.emailAddress,
                onChanged: context.read<LoginPageCubit>().onEmailChanged,
                error: switch (state.email.displayError) {
                  EmailValidationError.empty => 'Campo obrigatório!',
                  EmailValidationError.invalid => 'E-mail inválido!',
                  _ => null,
                },
              ),
              const SizedBox(height: 24),
              AppTextField(
                id: 'senha',
                title: 'Senha',
                hint: 'Mínimo de 8 dígitos',
                obscure: true,
                onChanged: context.read<LoginPageCubit>().onPasswordChanged,
                error: switch (state.password.displayError) {
                  PasswordValidationError.empty => 'Campo obrigatório',
                  _ => null,
                },
              ),
              const SizedBox(height: 24),
              AppElevatedButton(
                id: 'login',
                label: 'Entrar',
                onPressed: state.isValid
                    ? () {
                        // FirebaseCrashlytics.instance.crash();
                        FocusScope.of(context).unfocus();
                        context.read<LoginPageCubit>().onLoginPressed();
                      }
                    : null,
              ),
              const SizedBox(height: 24),
              const AppDivider(text: 'ou'),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSocialIcon(
                    onPressed: () {},
                    iconPath: 'assets/icons/social/apple.svg',
                  ),
                  const SizedBox(width: 8),
                  AppSocialIcon(
                    onPressed: () {},
                    iconPath: 'assets/icons/social/google.svg',
                  ),
                  const SizedBox(width: 8),
                  AppSocialIcon(
                    onPressed: () {},
                    iconPath: 'assets/icons/social/facebook_2.svg',
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void navToHome() {
    if (widget.redirectTo != null) {
      context.go(widget.redirectTo!);
    } else {
      context.go(AppRoutes.home);
    }
  }
}
