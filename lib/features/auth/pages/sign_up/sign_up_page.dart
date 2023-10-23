import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_base_page.dart';
import 'package:agendai/core/widgets/app_divider.dart';
import 'package:agendai/core/widgets/app_elevated_button.dart';
import 'package:agendai/core/widgets/app_logo.dart';
import 'package:agendai/core/widgets/app_social_icon.dart';
import 'package:agendai/core/widgets/app_text_field.dart';
import 'package:agendai/features/auth/models/cellphone.dart';
import 'package:agendai/features/auth/models/cpf.dart';
import 'package:agendai/features/auth/models/email.dart';
import 'package:agendai/features/auth/models/full_name.dart';
import 'package:agendai/features/auth/models/password.dart';
import 'package:agendai/features/auth/pages/sign_up/sign_up_actions.dart';
import 'package:agendai/features/auth/pages/sign_up/sign_up_cubit.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> implements SignUpActions {
  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return BlocProvider(
      create: (context) => SignUpCubit(this),
      child: BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
        return AppBasePage(
          title: 'Criar conta',
          isLoading: state.isLoading,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: AppLogo()),
              const SizedBox(height: 16),
              Text(
                'Cadastre-se',
                style: t.heading36Bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AppTextField(
                title: 'Nome Completo',
                hint: 'Ex: John doe',
                textInputType: TextInputType.name,
                onChanged: context.read<SignUpCubit>().onFullNameChanged,
                error: switch (state.fullName.displayError) {
                  FullNameValidationError.empty => 'Campo obrigatório!',
                  FullNameValidationError.incomplete =>
                    'Informe o nome completo!',
                  _ => null,
                },
              ),
              const SizedBox(height: 24),
              AppTextField(
                title: 'CPF',
                hint: 'Apenas números',
                textInputType: TextInputType.number,
                inputFormaters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                onChanged: context.read<SignUpCubit>().onCpfChanged,
                error: switch (state.cpf.displayError) {
                  CpfValidationError.empty => 'Campo obrigatório!',
                  CpfValidationError.invalid => 'CPF inválido!',
                  _ => null,
                },
              ),
              const SizedBox(height: 24),
              AppTextField(
                title: 'Telefone',
                hint: 'Apenas números',
                textInputType: TextInputType.phone,
                inputFormaters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
                onChanged: context.read<SignUpCubit>().onCellPhoneChanged,
                error: switch (state.cellPhone.displayError) {
                  CellPhoneValidationError.empty => 'Campo obrigatório!',
                  CellPhoneValidationError.invalid => 'Número inválido!',
                  _ => null,
                },
              ),
              const SizedBox(height: 32),
              AppTextField(
                title: 'E-mail',
                hint: 'Ex: nome@email.com',
                textInputType: TextInputType.emailAddress,
                onChanged: context.read<SignUpCubit>().onEmailChanged,
                error: switch (state.email.displayError) {
                  EmailValidationError.empty => 'Campo obrigatório!',
                  EmailValidationError.invalid => 'E-mail inválido!',
                  _ => null,
                },
              ),
              const SizedBox(height: 24),
              AppTextField(
                title: 'Senha',
                hint: 'Mínimo de 8 dígitos',
                obscure: true,
                onChanged: context.read<SignUpCubit>().onPasswordChanged,
                error: switch (state.password.displayError) {
                  PasswordValidationError.empty => 'Campo obrigatório',
                  PasswordValidationError.tooShort =>
                    'Digite pelo menos 8 digitos!',
                  _ => null,
                },
              ),
              const SizedBox(height: 24),
              AppElevatedButton(
                id: 'sign-up',
                label: 'Cadastrar',
                onPressed: state.isValid
                    ? () {
                        FocusScope.of(context).unfocus();
                        context.read<SignUpCubit>().onSignUpPressed();
                      }
                    : null,
                // onPressed: context.read<SignUpCubit>().onSignUpPressed,
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
    context.go(AppRoutes.home);
  }
}
