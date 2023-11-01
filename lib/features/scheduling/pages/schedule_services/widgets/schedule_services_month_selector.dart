import 'package:agendai/core/widgets/app_chip.dart';
import 'package:agendai/features/scheduling/pages/schedule_services/schedule_services_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:intl/intl.dart';

class ScheduleServicesMonthSelector extends AppState {
  const ScheduleServicesMonthSelector({super.key});

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return BlocBuilder<ScheduleServicesPageCubit, ScheduleServicesPageState>(
      builder: (context, state) {
        if (state.selectedServices.isEmpty) return Container();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data',
                    style: theme.body18Bold,
                  ),
                  Text(
                    'Selecione um mês para visualizar os dias disponíveis',
                    style: theme.body13,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.availableMonths.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (_, i) {
                  final month = state.availableMonths[i];
                  final selectedMonth = state.selectedMonth;
                  final isCurrent = month == selectedMonth;

                  return AppChip(
                    text: DateFormat('MMMM').format(month),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: theme.body16.copyWith(
                      color: isCurrent ? Colors.white : theme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    color: isCurrent ? theme.primary : Colors.white,
                    onTap: () => context
                        .read<ScheduleServicesPageCubit>()
                        .changeSelectMonth(month),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
              ),
            ),
          ],
        );
      },
    );
  }
}
