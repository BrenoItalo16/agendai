import 'package:agendai/core/device/app_external_launcher.dart';
import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/firebase/remote_config/app_remote_config.dart';
import 'package:agendai/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: IntroBasePage(
                imagePath: 'assets/img/maintenance.svg',
                title: 'App em manutenção',
                body:
                    'Nosso app está recebendo melhorias, mas logo estaremos de volta. Para ficar por dentro das novidades, acompanhe nossas redes sociais.',
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      getIt<AppExternalLauncher>().launchUrl(
                        'https://twitter.com/BrenoItalo_16',
                      );
                    },
                    child: SvgPicture.asset('assets/icons/social/x.svg'),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      getIt<AppExternalLauncher>().launchUrl(
                        getIt<AppRemoteConfig>().instagramUrl,
                      );
                    },
                    child: SvgPicture.asset('assets/icons/social/insta.svg'),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      getIt<AppExternalLauncher>().launchUrl(
                        'https://facebook.com/brenoitalo16',
                      );
                    },
                    child: SvgPicture.asset('assets/icons/social/facebook.svg'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
