import 'package:agendai/core/widgets/app_simple_header.dart';
import 'package:agendai/features/home/pages/notifications/notifications_page_cubit.dart';
import 'package:agendai/features/home/pages/notifications/widgets/notifications_list_area.dart';
import 'package:agendai/features/home/pages/notifications/widgets/notifications_switch.dart';
import 'package:flutter/material.dart';

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
    // final AppTheme theme = context.watch();

    super.build(context);

    return Column(
      children: [
        const AppSimpleHeader(title: "Notificações"),
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
              NotificationsListArea(status: NotificationStatus.notRead),
              NotificationsListArea(status: NotificationStatus.read),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
