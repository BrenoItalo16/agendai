import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_card.dart';
import 'package:agendai/core/widgets/app_chip.dart';
import 'package:agendai/features/scheduling/models/scheduling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class HomeNextScheduleItem extends StatelessWidget {
  const HomeNextScheduleItem({super.key, required this.scheduling});

  final Scheduling scheduling;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return AppCard(
      onPressed: () {
        context.push(
          AppRoutes.professionalDetails(id: scheduling.professional.id),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppChip(
                  text: DateFormat('dd MMM HH:mm').format(scheduling.startDate),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      scheduling.services.map((s) => s.name).join(' | '),
                      style: t.body16Bold,
                    ),
                  ),
                ),
                Text(
                  scheduling.professional.name,
                  style: t.body13.copyWith(color: t.txtColor),
                ),
              ],
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: t.primary.withOpacity(0.18),
            ),
            child: Icon(
              IconlyLight.location,
              color: t.primary,
            ),
          ),
        ],
      ),
    );
  }
}
