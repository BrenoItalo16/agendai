import 'package:agendai/core/widgets/app_empty_state_indicator.dart';
import 'package:agendai/core/widgets/app_loading_indicator.dart';
import 'package:agendai/features/home/pages/home/sections/next_schedules/widgets/home_next_schedule_item.dart';
import 'package:agendai/features/home/pages/schedulings/schedulings_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulingsListArea extends StatefulWidget {
  const SchedulingsListArea({Key? key, required this.status}) : super(key: key);

  final SchedulingsStatus status;

  @override
  State<SchedulingsListArea> createState() => _SchedulingsListAreaState();
}

class _SchedulingsListAreaState extends State<SchedulingsListArea>
    with AutomaticKeepAliveClientMixin {
  late final SchedulingsPageCubit cubit =
      SchedulingsPageCubit(status: widget.status);

  @override
  void initState() {
    super.initState();

    cubit.loadSchedulings();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<SchedulingsPageCubit, SchedulingsPageState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: AppLoadingIndicator(),
            );
          }

          if (state.schedulings == null) return Container();

          if (state.schedulings!.isEmpty) {
            return const AppEmptyStateIndicator(
              icon: Icons.calendar_today,
              message: 'Você não possui agendamentos ainda!',
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              padding: MediaQuery.paddingOf(context).add(
                const EdgeInsets.fromLTRB(24, 0, 24, 24),
              ),
              itemBuilder: (_, i) {
                if (i < state.schedulings!.length) {
                  final scheduling = state.schedulings![i];
                  return SizedBox(
                    height: 120 + 18,
                    child: HomeNextScheduleItem(
                      scheduling: scheduling,
                      shadowOffset: const Offset(3, 6),
                    ),
                  );
                } else {
                  cubit.loadSchedulings();
                  return const Center(
                    child: AppLoadingIndicator(),
                  );
                }
              },
              itemCount:
                  state.schedulings!.length + (state.finishedLoading ? 0 : 1),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
