import 'package:agendai/core/alert/alert_area_cubit.dart';
import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/widgets/app_text_button.dart';
import 'package:agendai/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  NotFoundPage({Key? key}) : super(key: key);

  int count = 0;

  @override
  Widget build(BuildContext context) {
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
                label: 'Voltar',
                onPressed: () {
                  getIt<AlertAreaCubit>().showAlert(
                    Alert.success(title: 'Este é um alerta legal! $count'),
                  );
                  count++;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
