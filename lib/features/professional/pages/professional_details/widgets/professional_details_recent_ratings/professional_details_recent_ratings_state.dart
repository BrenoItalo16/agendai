part of 'professional_details_recent_ratings_cubit.dart';

enum ProfessionalDetailsRecentRatingsStatus {
  loading,
  error,
  success,
}

class ProfessionalDetailsRecentRatingsState extends Equatable {
  const ProfessionalDetailsRecentRatingsState({
    this.ratings,
    this.status = ProfessionalDetailsRecentRatingsStatus.loading,
  });

  final ProfessionalDetailsRecentRatingsStatus status;
  final List<Rating>? ratings;

  @override
  List<Object?> get props => [status, ratings];

  ProfessionalDetailsRecentRatingsState copyWith({
    ProfessionalDetailsRecentRatingsStatus? status,
    List<Rating>? ratings,
  }) {
    return ProfessionalDetailsRecentRatingsState(
      status: status ?? this.status,
      ratings: ratings ?? this.ratings,
    );
  }
}
