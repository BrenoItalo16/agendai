import 'package:agendai/core/widgets/app_card.dart';
import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:agendai/features/professional/models/professional_details.dart';
import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:iconly/iconly.dart';

class ProfessionalBasicDetailsWidget extends AppStateless {
  const ProfessionalBasicDetailsWidget({required this.professional, super.key});

  final ProfessionalDetails professional;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: theme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  image: professional.picture != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            professional.picture!,
                          ),
                        )
                      : null,
                ),
                child: professional.picture != null
                    ? null
                    : Icon(
                        IconlyLight.profile,
                        color: theme.primary,
                      ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      professional.name,
                      style: theme.body16Bold,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          IconlyBold.star,
                          color: theme.secondary,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          professional.rating.toStringAsFixed(1),
                          style: theme.body16,
                        ),
                        Text(
                          ' (${professional.ratingCount.toString()})',
                          style: theme.body13,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'CRM: ${professional.crm}',
                      style: theme.label12,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Especialidades',
            style: theme.body16Bold,
          ),
          const SizedBox(height: 10),
          Text(
            professional.specialties.map((e) => e.name).join(' | '),
            style: theme.body16,
          ),
          const SizedBox(height: 18),
          Text(
            'Convênios',
            style: theme.body16Bold,
          ),
          const SizedBox(height: 10),
          Text(
            professional.insurances.map((e) => e.name).join(' | '),
            style: theme.body16,
          ),
        ],
      ),
    );
  }
}
