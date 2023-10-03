import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_base_page.dart';
import 'package:agendai/features/professional/pages/professional_ratings/professional_ratings_page_cubit.dart';
import 'package:agendai/features/professional/widgets/professional_rating_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfessionalRatingsPage extends StatefulWidget {
  const ProfessionalRatingsPage({super.key, required this.id});

  final String id;

  @override
  State<ProfessionalRatingsPage> createState() =>
      _ProfessionalRatingsPageState();
}

class _ProfessionalRatingsPageState extends State<ProfessionalRatingsPage> {
  late final ProfessionalRatingsPageCubit cubit = ProfessionalRatingsPageCubit(
    professionalId: widget.id,
  );

  @override
  void initState() {
    super.initState();
    cubit.loadingRatings();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return BlocBuilder<ProfessionalRatingsPageCubit,
        ProfessionalRatingsPageState>(
      bloc: cubit,
      builder: (context, state) {
        return AppBasePage(
          title: 'Avaliações',
          isLoading: state.isLoading,
          type: AppBasePageType.fixed,
          body: state.ratings != null
              ? ListView.separated(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  padding: MediaQuery.paddingOf(context).add(
                    const EdgeInsets.fromLTRB(24, 110, 24, 24),
                  ),
                  itemBuilder: (_, i) {
                    if (i < state.ratings!.length) {
                      final rating = state.ratings![i];
                      return ProfessionalRatingListItem(rating: rating);
                    } else {
                      cubit.loadingRatings();
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: theme.primary,
                          size: 56,
                        ),
                      );
                    }
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount:
                      state.ratings!.length + (state.finishedLoading ? 0 : 1),
                )
              : Container(),
        );
      },
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
