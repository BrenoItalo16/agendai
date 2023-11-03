import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_elevated_button.dart';
import 'package:agendai/core/widgets/app_session_observer.dart';
import 'package:agendai/core/widgets/app_simple_header.dart';
import 'package:agendai/core/widgets/app_elevated_switch.dart';
import 'package:agendai/features/home/pages/schedulings/schedulings_page_cubit.dart';
import 'package:agendai/features/home/pages/schedulings/widgets/schedulings_list_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SchedulingsPage extends StatefulWidget {
  const SchedulingsPage({Key? key}) : super(key: key);

  @override
  State<SchedulingsPage> createState() => _SchedulingsPageState();
}

class _SchedulingsPageState extends State<SchedulingsPage>
    with AutomaticKeepAliveClientMixin {
  bool showHistory = false;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final AppTheme theme = context.watch();

    return Column(
      children: [
        const AppSimpleHeader(title: 'Agendamentos'),
        Expanded(
          child: AppSessionObserver(
            builder: (_, state) {
              if (state.loggedUser != null) {
                return Column(
                  children: [
                    AppElevatedSwitch(
                      disabledText: 'Próximos',
                      enabledText: 'Histórico',
                      enabled: showHistory,
                      onChanged: (r) {
                        setState(() {
                          showHistory = r;
                        });
                        pageController.animateToPage(
                          showHistory ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          SchedulingsListArea(status: SchedulingsStatus.future),
                          SchedulingsListArea(status: SchedulingsStatus.past),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      size: 100,
                      color: theme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Entre para ver seus agendamentos!',
                      style: theme.body16Bold,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: AppElevatedButton(
                        id: 'entrar',
                        label: 'Entrar',
                        onPressed: () {
                          final uri = Uri(
                              path: AppRoutes.login.fullPath,
                              queryParameters: {
                                'redirectTo':
                                    '${AppRoutes.home}?initialTab=schedulings'
                              });
                          context.go(uri.toString());
                        },
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
