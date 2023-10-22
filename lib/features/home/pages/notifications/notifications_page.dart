import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_outlined_button.dart';
import 'package:agendai/core/widgets/app_session_observer.dart';
import 'package:agendai/core/widgets/app_simple_header.dart';
import 'package:agendai/features/home/pages/notifications/notifications_page_cubit.dart';
import 'package:agendai/features/home/pages/notifications/widgets/notifications_list_area.dart';
import 'package:agendai/features/home/pages/notifications/widgets/notifications_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with AutomaticKeepAliveClientMixin {
  bool showRead = false;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();

    super.build(context);

    return Column(
      children: [
        const AppSimpleHeader(title: "Notificações"),
        Expanded(
          child: AppSessionObserver(
            listener: (state) {},
            builder: (_, state) {
              if (state.loggedUser != null) {
                return Column(
                  children: [
                    NotificationsSwitch(
                      showRead: showRead,
                      onChanged: (r) {
                        setState(() {
                          showRead = r;
                        });
                        pageController.animateToPage(
                          showRead ? 1 : 0,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease,
                        );
                      },
                    ),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          NotificationsListArea(
                              status: NotificationStatus.notRead),
                          NotificationsListArea(
                              status: NotificationStatus.read),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Expanded(
                      // flex: 2,
                      child: Center(
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).width * 0.8,
                          child: SvgPicture.asset(
                            'assets/img/empty_notification.svg',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            Text(
                              'Faça login',
                              textAlign: TextAlign.center,
                              style: theme.body24Bold,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Você precisa fazer login para ter acesso as suas notificações',
                              textAlign: TextAlign.center,
                              style: theme.body13,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 180,
                              child: AppOutlinedButton(
                                label: "Entrar",
                                onPressed: () {
                                  final uri = Uri(
                                    path: AppRoutes.login.fullpath,
                                    queryParameters: {
                                      'redirectTo':
                                          '${AppRoutes.home}?initialTab=notifications',
                                    },
                                  );
                                  context.go(uri.toString());
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
