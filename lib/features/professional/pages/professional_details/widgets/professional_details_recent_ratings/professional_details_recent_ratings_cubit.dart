import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/helpers/result.dart';
import 'package:agendai/features/professional/data/professional_repository.dart';
import 'package:agendai/features/professional/models/rating.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'professional_details_recent_ratings_state.dart';

class ProfessionalDetailsRecentRatingsCubit
    extends Cubit<ProfessionalDetailsRecentRatingsState> {
  ProfessionalDetailsRecentRatingsCubit(
      {ProfessionalRepository? professionalRepository})
      : _professionalRepository = professionalRepository ?? getIt(),
        super(const ProfessionalDetailsRecentRatingsState());

  final ProfessionalRepository _professionalRepository;

  Future<void> loadRatings(String professionalId) async {
    final result = await _professionalRepository.getProfessionalRatings(
      professionalId: professionalId,
      itemsPerPage: 3,
      page: 0,
    );
    emit(switch (result) {
      Success(:final object) => state.copyWith(
          status: ProfessionalDetailsRecentRatingsStatus.success,
          ratings: object,
        ),
      Failure() => state.copyWith(
          status: ProfessionalDetailsRecentRatingsStatus.error,
        ),
    });
  }
}
