import 'package:agendai/core/device/app_device_settings.dart';
import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_alert_dialog.dart';
import 'package:agendai/core/widgets/app_elevated_button.dart';
import 'package:agendai/core/widgets/app_outlined_button.dart';
import 'package:agendai/core/widgets/app_text_button.dart';
import 'package:agendai/features/intro/pages/onboarding/onboarding_page_actions.dart';
import 'package:agendai/features/intro/pages/onboarding/onboarding_page_cubit.dart';
import 'package:agendai/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    implements OnboardingPageActions {
  final PageController pageController = PageController();
  late final OnboardingPageCubit cubit = OnboardingPageCubit(this);

  int page = 0;

  @override
  void initState() {
    super.initState();
    cubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body: BlocBuilder<OnboardingPageCubit, OnboardingPageState>(
          builder: (context, state) {
            final pages = [
              OnboardingPageInfo(
                title: 'Olá',
                body:
                    'Seja bem-vindo(a) ao Agendaí, o seu app de agendamentos!',
                imagePath: 'assets/img/bemvindo.svg',
                nextButtonLabel: 'Vamos começar',
              ),
              if (state.showLocationPage) //! Comentar para ver as páginas
                OnboardingPageInfo(
                  title: 'Acesso à localização',
                  body:
                      'Para prosseguir é necessário que você autorize as notificações neste aparelho!',
                  imagePath: 'assets/img/location.svg',
                  onNextPressed: cubit.requestLocationPermission,
                ),
              if (state.showNotificationPage)
                OnboardingPageInfo(
                  title: 'Ative as\nnotificações',
                  body:
                      'Para receber avisos importantes sobre agendamentos neste aparelho!',
                  imagePath: 'assets/img/notification.svg',
                  onNextPressed: cubit.requestNotificationPermission,
                ),
              OnboardingPageInfo(
                title: 'Tudo pronto',
                body: 'Vamos começar',
                imagePath: 'assets/img/ready.svg',
                onNextPressed: cubit.finish,
                nextButtonLabel: 'Começar',
              ),
            ];

            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for (final p in pages)
                        IntroBasePage(
                          imagePath: p.imagePath,
                          title: p.title,
                          body: p.body,
                        ),
                    ],
                    onPageChanged: (p) {
                      setState(() {
                        page = p;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: pages.length, //! Quantidade de páginas
                    effect: ExpandingDotsEffect(
                      activeDotColor: t.primary,
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: t.grey700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 44),
                  child: Row(
                    children: [
                      if (page > 0) ...[
                        AppTextButton(
                          color: t.primary,
                          label: 'Voltar',
                          onPressed: () {
                            pageController.animateToPage(
                              page - 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                      ],
                      Expanded(
                        child: AppElevatedButton(
                          label: pages[page].nextButtonLabel ?? 'Próximo',
                          icon: IconlyBold.arrow_right_2,
                          onPressed: () async {
                            await pages[page].onNextPressed?.call();

                            pageController.animateToPage(
                              page + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Future<void> showDeniedForeverDialog() {
    return showDialog(
      context: context,
      builder: (_) => AppAlertDialog(
        title: 'Autorização negada',
        body:
            'Você não autorizou esta permissão! Acesse as configurações do seu dispositivo para permitir.',
        actions: [
          AppOutlinedButton(
            label: 'Prosseguir mesmo assim',
            onPressed: Navigator.of(context).pop,
          ),
          AppElevatedButton(
            label: 'Ir para configurações',
            onPressed: () async {
              await getIt<AppDeviceSettings>().openSettings();
              if (context.mounted) Navigator.of(context).pop;
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cubit.dispose();
    cubit.close();
    pageController.dispose();
    super.dispose();
  }

  @override
  void navToAuth() {
    context.go(AppRoutes.auth);
  }
}

class OnboardingPageInfo {
  OnboardingPageInfo({
    required this.title,
    required this.body,
    required this.imagePath,
    this.onNextPressed,
    this.nextButtonLabel,
  });

  final String title;
  final String body;
  final String imagePath;
  final Function? onNextPressed;
  final String? nextButtonLabel;
}
