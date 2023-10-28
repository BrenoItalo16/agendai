import 'package:agendai/features/home/home_page.dart';
import 'package:agendai/features/home/pages/base/widgets/bottom_nav_bar.dart';
import 'package:agendai/features/home/pages/notifications/notifications_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum BasePageTab { home, calendar, menu, notifications, profile }

class BasePage extends StatefulWidget {
  const BasePage({Key? key, required this.initialTab}) : super(key: key);

  final String? initialTab;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late int page = widget.initialTab != null
      ? BasePageTab.values
              .firstWhereOrNull(
                (element) => element.name == widget.initialTab,
              )
              ?.index ??
          0
      : 0;

  late final PageController pageController =
      PageController(keepPage: true, initialPage: page);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        page: page,
        onChanged: (p) {
          setState(() {
            page = p;
          });
          pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
      extendBody: true,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomePage(),
          Container(color: Colors.grey[200]),
          PageView(
            scrollDirection: Axis.vertical,
            children: [
              Stack(
                children: [
                  Center(
                    child: Image.network(
                      'https://pbs.twimg.com/media/FSgl1OfUcAEsiQV?format=jpg&name=large',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 350,
                      width: 350,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(36)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const NotificationsPage(),
          Container(color: Colors.grey[200]),
        ],
      ),
    );
  }
}
