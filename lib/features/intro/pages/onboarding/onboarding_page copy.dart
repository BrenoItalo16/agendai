import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_elevated_button.dart';
import 'package:agendai/core/widgets/app_text_button.dart';
import 'package:agendai/features/intro/pages/onboarding/onboarding_page_actions.dart';
import 'package:agendai/features/intro/pages/onboarding/onboarding_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    implements OnboardingPageActions {
  final PageController pageController = PageController();
  late final OnboardingPageCubit cubit = OnboardingPageCubit(this);

  int page = 0;

  @override
  Widget build(BuildContext context) {
    final appWidth = MediaQuery.of(context).size.width;
    AppTheme t = context.watch();
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body: BlocBuilder<OnboardingPageCubit, OnboardingPageState>(
          builder: (context, state) {
            final pages = [
              OnboardingPageInfo(
                  title: 'Olá',
                  description:
                      'Seja bem-vindo(a) ao Agendaí, o seu app de agendamentos!',
                  imagePath: 'assets/img/bemvindo.svg',
                  nextButtonLabel: 'Vamos começar'),
              if (state.showLocationPage) //! Comentar para ver as páginas
                OnboardingPageInfo(
                  title: 'Acesso à localização',
                  description:
                      'Para prosseguir é necessário autorização de notificações neste aparelho!',
                  imagePath: 'assets/img/location.svg',
                  onNextPressed: cubit.requestLocationPermission,
                ),
              if (state.showNotificationPage) //! Comentar para ver a página
                OnboardingPageInfo(
                  title: 'Ative as notificações',
                  description:
                      'Para receber avisos importantes sobre agendamentos neste aparelho!',
                  imagePath: 'assets/img/notification.svg',
                  onNextPressed: cubit.requestNotificationPermission,
                ),
              OnboardingPageInfo(
                title: 'Tudo pronto',
                description: 'Vamos começar!',
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: SvgPicture.asset(
                                  p.imagePath,
                                  width: appWidth * 0.8,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                p.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: t.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                p.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: t.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                    onPageChanged: (p) {
                      setState(
                        () {
                          page = p;
                        },
                      );
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
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                  child: Row(
                    children: [
                      if (page > 0) ...[
                        AppTextButton(
                          label: 'Voltar',
                          onPressed: () {
                            pageController.animateToPage(
                              page - 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                      Expanded(
                        child: AppElevatedButton(
                          label: pages[page].nextButtonLabel ?? 'Próximo',
                          icon: IconlyBold.arrow_right_2,
                          onPressed: () async {
                            pages[page].onNextPressed?.call();
                            pageController.animateToPage(
                              page + 1,
                              duration: const Duration(microseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
      builder: (_) => AlertDialog(
        content: Container(
          color: Colors.red,
          width: 50,
          height: 50,
        ),
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
    required this.description,
    required this.imagePath,
    this.onNextPressed,
    this.nextButtonLabel,
  });

  final String title;
  final String description;
  final String imagePath;
  final Function? onNextPressed;
  final String? nextButtonLabel;
}
