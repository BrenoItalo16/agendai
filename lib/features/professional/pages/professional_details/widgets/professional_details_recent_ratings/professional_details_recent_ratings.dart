import 'package:agendai/core/route/app_routes.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_outlined_button.dart';
import 'package:agendai/features/professional/pages/professional_details/widgets/app_loading_ratings.dart';
import 'package:agendai/features/professional/pages/professional_details/widgets/professional_details_recent_ratings/professional_details_recent_ratings_cubit.dart';
import 'package:agendai/features/professional/widgets/professional_rating_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfessionalDetailsRecentRatings extends StatefulWidget {
  const ProfessionalDetailsRecentRatings(
      {super.key, required this.professionalId});

  final String professionalId;

  @override
  State<ProfessionalDetailsRecentRatings> createState() =>
      _ProfessionalDetailsRecentRatingsState();
}

class _ProfessionalDetailsRecentRatingsState
    extends State<ProfessionalDetailsRecentRatings> {
  final ProfessionalDetailsRecentRatingsCubit cubit =
      ProfessionalDetailsRecentRatingsCubit();

  @override
  void initState() {
    super.initState();

    cubit.loadRatings(widget.professionalId);
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return BlocBuilder<ProfessionalDetailsRecentRatingsCubit,
        ProfessionalDetailsRecentRatingsState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('Avaliações', style: t.body18Bold)),
                if (state.status ==
                    ProfessionalDetailsRecentRatingsStatus.success)
                  AppOutlinedButton(
                    label: 'Ver todas',
                    minHeight: 32,
                    onPressed: () => context.push(
                      AppRoutes.professionalRatings.fullPath(
                        id: widget.professionalId,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            switch (state.status) {
              ProfessionalDetailsRecentRatingsStatus.error => Container(),
              ProfessionalDetailsRecentRatingsStatus.loading =>
                const AppLoadingRatings(),
              ProfessionalDetailsRecentRatingsStatus.success =>
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, i) {
                    final rating = state.ratings![i];
                    return ProfessionalRatingListItem(rating: rating);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: state.ratings!.length,
                ),
            },
          ],
        );
      },
    );
  }
}
