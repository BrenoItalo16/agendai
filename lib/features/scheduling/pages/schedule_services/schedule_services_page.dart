import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_base_page.dart';
import 'package:agendai/core/widgets/app_elevated_button.dart';
import 'package:agendai/features/scheduling/pages/schedule_services/schedule_services_page_cubit.dart';
import 'package:agendai/features/scheduling/pages/schedule_services/widgets/schedule_services_day_selector.dart';
import 'package:agendai/features/scheduling/pages/schedule_services/widgets/schedule_services_month_selector.dart';
import 'package:agendai/features/scheduling/pages/schedule_services/widgets/schedule_services_services_selector.dart';
import 'package:agendai/features/scheduling/pages/schedule_services/widgets/schedule_services_time_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleServicesPage extends StatefulWidget {
  const ScheduleServicesPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<ScheduleServicesPage> createState() => _ScheduleServicesPageState();
}

class _ScheduleServicesPageState extends State<ScheduleServicesPage> {
  late final cubit = ScheduleServicesPageCubit(professionalId: widget.id);

  @override
  void initState() {
    super.initState();

    cubit.getProfessional();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ScheduleServicesPageCubit, ScheduleServicesPageState>(
        builder: (context, state) {
          return AppBasePage(
            type: AppBasePageType.scroll,
            backgroundColor: theme.white,
            isLoading: state.loading,
            title: 'Agendar',
            bottomAction: AppElevatedButton(
              label: 'Agendar',
              id: 'agendar',
              onPressed: () {},
            ),
            bodyPadding: EdgeInsets.zero,
            body: state.professional != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ScheduleServicesServicesSelector(),
                      const SizedBox(height: 16),
                      const ScheduleServicesMonthSelector(),
                      const SizedBox(height: 24),
                      BlocBuilder<ScheduleServicesPageCubit,
                          ScheduleServicesPageState>(
                        builder: (context, state) {
                          final cubit =
                              context.read<ScheduleServicesPageCubit>();

                          if (state.selectedServices.isEmpty)
                            return Container();

                          return ScheduleServicesDaySelector(
                            currentMonth: state.selectedMonth,
                            lastDay: state.lastAvailableDay,
                            onMonthChanged: cubit.changeSelectMonth,
                            onRangeChanged: cubit.onRangeChanged,
                            onDaySelected: cubit.onDayChanged,
                            daySlots: state.daySlots,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      const ScheduleServicesTimeSelector(),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
