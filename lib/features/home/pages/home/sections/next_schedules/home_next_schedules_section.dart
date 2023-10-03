import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_card.dart';
import 'package:agendai/core/widgets/app_session_observer.dart';
import 'package:agendai/core/widgets/app_skeleton.dart';
import 'package:agendai/features/home/pages/home/sections/next_schedules/home_next_schedules_cubit.dart';
import 'package:agendai/features/home/pages/home/sections/next_schedules/widgets/home_next_schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNextSchedulesSection extends StatefulWidget {
  const HomeNextSchedulesSection({super.key});

  @override
  State<HomeNextSchedulesSection> createState() =>
      _HomeNextSchedulesSectionState();
}

class _HomeNextSchedulesSectionState extends State<HomeNextSchedulesSection> {
  final HomeNextSchedulesCubit cubit = HomeNextSchedulesCubit();

  void loadingSchedulings(bool isLoggedIn) {
    if (isLoggedIn) {
      cubit.loadSchedulings();
    } else {
      cubit.setUserNotLoggedIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTheme t = context.watch();

    return AppSessionObserver(
      listener: (sessionState) {
        loadingSchedulings(sessionState.loggedUser != null);
      },
      child: BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Próximos agendamentos',
                  style: t.body18Bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 120 * MediaQuery.textScaleFactorOf(context) + 28,
                child:
                    BlocBuilder<HomeNextSchedulesCubit, HomeNextSchedulesState>(
                  builder: (context, state) {
                    return switch (state.status) {
                      HomeNextSchedulesStatus.loading => AppSkeleton(
                          margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: OverflowBox(
                            maxWidth: 600,
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                const SizedBox(width: 24),
                                AppCard(width: 270, child: Container()),
                                const SizedBox(width: 16),
                                AppCard(width: 270, child: Container()),
                              ],
                            ),
                          ),
                        ),
                      HomeNextSchedulesStatus.notLoggedIn => Container(
                          color: Colors.blue,
                        ),
                      HomeNextSchedulesStatus.error => Container(
                          color: Colors.amberAccent,
                        ),
                      HomeNextSchedulesStatus.success => ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, i) => const SizedBox(width: 16),
                          itemCount: state.schedulings!.length,
                          itemBuilder: (_, i) => SizedBox(
                            width: state.schedulings!.length == 1
                                ? MediaQuery.sizeOf(context).width - 48
                                : 270,
                            child: HomeNextScheduleItem(
                              scheduling: state.schedulings![i],
                            ),
                          ),
                        ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
