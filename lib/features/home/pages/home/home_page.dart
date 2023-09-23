import 'package:agendai/features/home/pages/home/sections/home_header_section.dart';
import 'package:agendai/features/home/pages/home/sections/next_schedules/home_next_schedules_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeHeaderSection(),
          Expanded(
            child: ListView(
              children: const [
                HomeNextSchedulesSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
