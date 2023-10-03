import 'package:agendai/core/widgets/base/app_stateless.dart';
import 'package:agendai/features/professional/models/professional_details.dart';
import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';

class ProfessionalDetailsServicesWidget extends AppStateless {
  const ProfessionalDetailsServicesWidget(
      {required this.professional, super.key});

  final ProfessionalDetails professional;
  @override
  Widget builder(BuildContext context, AppTheme t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Serviços',
          style: t.body18Bold,
        ),
        for (final s in professional.services)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: t.secondary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(s.name, style: t.body16)),
              ],
            ),
          ),
      ],
    );
  }
}
