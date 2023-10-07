import 'package:agendai/features/home/home_page.dart';
import 'package:agendai/features/home/pages/base/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int page = 0;

  final PageController pageController = PageController();

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
          Container(color: Colors.red),
          Container(color: Colors.grey[200]),
          Container(color: Colors.green),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}