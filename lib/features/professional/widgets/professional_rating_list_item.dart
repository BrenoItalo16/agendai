import 'package:agendai/core/widgets/base/app_state.dart';
import 'package:agendai/features/professional/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:iconly/iconly.dart';

class ProfessionalRatingListItem extends AppStateless {
  const ProfessionalRatingListItem({super.key, required this.rating});

  final Rating rating;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rating.userName,
          style: theme.body16Bold,
        ),
        Row(
          children: [
            for (int i = 0; i < 5; i++)
              Icon(
                IconlyBold.star,
                size: 18,
                color: i < rating.stars ? theme.secondary : theme.grey,
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          rating.comments,
          style: theme.body16,
        ),
      ],
    );
  }
}
