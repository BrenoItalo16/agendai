import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_base_page.dart';
import 'package:agendai/core/widgets/app_card.dart';
import 'package:agendai/core/widgets/app_check_box.dart';
import 'package:agendai/core/widgets/app_chip.dart';
import 'package:agendai/core/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/schedule_services_day_selector.dart';

class ScheduleServicesPage extends StatefulWidget {
  const ScheduleServicesPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<ScheduleServicesPage> createState() => _ScheduleServicesPageState();
}

class _ScheduleServicesPageState extends State<ScheduleServicesPage> {
  int day = 3;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();

    return AppBasePage(
      type: AppBasePageType.scroll,
      backgroundColor: theme.white,
      title: 'Agendar',
      bottomAction: AppElevatedButton(
        label: 'Agendar',
        id: 'agendar',
        onPressed: () {},
      ),
      bodyPadding: EdgeInsets.zero,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Serviços',
                  style: theme.body18Bold,
                ),
                Text(
                  'Selecione um ou mais serviços para avançar',
                  style: theme.body13,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (_, i) => AppCard(
              shadowEnabled: false,
              color: theme.white,
              onPressed: () {},
              padding: const EdgeInsets.fromLTRB(10, 8, 20, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppCheckBox(
                    checked: true,
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Exame',
                          textAlign: TextAlign.start,
                          style: theme.body16Bold,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Duração: 30 min',
                                style: theme.body16,
                              ),
                            ),
                            Text(
                              'R\$ 150',
                              style: theme.body18Bold,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            itemCount: 3,
          ),
          const SizedBox(height: 16),
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
          Row(
            children: [
              const SizedBox(width: 20),
              AppChip(
                text: 'Junho',
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textStyle: theme.body16.copyWith(
                  color: theme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              AppChip(
                text: 'Julho',
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textStyle: theme.body16.copyWith(
                  color: theme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              AppChip(
                text: 'Agosto',
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textStyle: theme.body16.copyWith(
                  color: theme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const ScheduleServicesDaySelector(),
          const SizedBox(height: 24),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              runSpacing: 8,
              spacing: 8,
              children: [
                for (int i = 0; i < 10; i++)
                  AppChip(
                    text: 'Agosto',
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: theme.body16.copyWith(
                      color: theme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
