import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_text_button.dart';
import 'package:agendai/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme t = context.watch();
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: IntroBasePage(
                imagePath: 'assets/img/not_found.svg',
                title: 'Opss!',
                body: 'A página que você está procurando não foi encontrada!',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppTextButton(
                color: t.primary,
                label: 'Voltar',
                onPressed: () => context.go(AppRoutes.home),
              ),
            ),
          )
        ],
      ),
    );
  }
}
