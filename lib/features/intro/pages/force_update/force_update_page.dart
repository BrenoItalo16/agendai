import 'package:agendai/core/device/app_external_launcher.dart';
import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/widgets/app_elevated_button.dart';
import 'package:agendai/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';

class ForceUpdatePage extends StatelessWidget {
  const ForceUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: IntroBasePage(
                imagePath: 'assets/img/force_update.svg',
                title: 'Atualização necessária',
                body:
                    'Atualize seu aplicativo para a versão mais recente e ficar por dentro de todas as novidade.',
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: AppElevatedButton(
                label: 'Atualização necessãria',
                onPressed: getIt<AppExternalLauncher>().launchStore,
              ),
            ),
          )
        ],
      ),
    );
  }
}
