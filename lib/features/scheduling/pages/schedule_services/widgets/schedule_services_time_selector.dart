import 'package:agendai/core/widgets/app_chip.dart';
import 'package:agendai/features/scheduling/pages/schedule_services/schedule_services_page_cubit.dart';
import 'package:flutter/material.dart';

import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScheduleServicesTimeSelector extends AppState {
  const ScheduleServicesTimeSelector({super.key});

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return BlocBuilder<ScheduleServicesPageCubit, ScheduleServicesPageState>(
      builder: (context, state) {
        if (state.selectedServices.isEmpty || state.selectedDay == null)
          return Container();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Horários disponíveis',
                    style: theme.body18Bold,
                  ),
                  Text(
                    'Selecione um horário para realizar o agendamento',
                    style: theme.body13,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (state.selectedDaySlots != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    children: [
                      for (final slot in state.selectedDaySlots!.slots)
                        AppChip(
                          text: DateFormat('HH:mm').format(slot.startDate),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          textStyle: theme.body16.copyWith(
                            color: slot.startDate == state.selectedDay
                                ? Colors.white
                                : theme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          color: slot.startDate == state.selectedDay
                              ? theme.primary
                              : Colors.white,
                          onTap: () {
                            context
                                .read<ScheduleServicesPageCubit>()
                                .onDayChanged(slot.startDate);
                          },
                        ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
