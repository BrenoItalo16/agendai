import 'package:agendai/features/home/pages/home/sections/home_header_section.dart';
import 'package:agendai/features/home/pages/home/sections/next_schedules/home_next_schedules_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        const HomeHeaderSection(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              HomeNextSchedulesSection(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
