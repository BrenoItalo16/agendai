import 'package:agendai/core/widgets/app_card.dart';
import 'package:agendai/core/widgets/base/app_stateless.dart';
import 'package:agendai/features/professional/models/professional_details.dart';
import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:iconly/iconly.dart';

class ProfessionalBasicDetailsWidget extends AppStateless {
  const ProfessionalBasicDetailsWidget({required this.professional, super.key});

  final ProfessionalDetails professional;

  @override
  Widget builder(BuildContext context, AppTheme t) {
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
                  color: t.primary.withOpacity(0.1),
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
                        color: t.primary,
                      ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      professional.name,
                      style: t.body16Bold,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          IconlyBold.star,
                          color: t.secondary,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          professional.rating.toStringAsFixed(1),
                          style: t.body16,
                        ),
                        Text(
                          ' (${professional.ratingCount.toString()})',
                          style: t.body13,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'CRM: ${professional.crm}',
                      style: t.label12,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Especialidades',
            style: t.body16Bold,
          ),
          const SizedBox(height: 10),
          Text(
            professional.specialties.map((e) => e.name).join(' | '),
            style: t.body16,
          ),
          const SizedBox(height: 18),
          Text(
            'Convênios',
            style: t.body16Bold,
          ),
          const SizedBox(height: 10),
          Text(
            professional.insurances.map((e) => e.name).join(' | '),
            style: t.body16,
          ),
        ],
      ),
    );
  }
}
