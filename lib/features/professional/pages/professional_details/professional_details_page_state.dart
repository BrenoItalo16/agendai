part of 'professional_details_page_cubit.dart';

class ProfessionalDetailsPageState extends Equatable {
  const ProfessionalDetailsPageState(
      {this.professional, this.isLoading = false});

  final bool isLoading;
  final ProfessionalDetails? professional;

  @override
  List<Object?> get props => [professional, isLoading];

  ProfessionalDetailsPageState copyWith({
    bool? isLoading,
    ProfessionalDetails? professional,
  }) {
    return ProfessionalDetailsPageState(
      isLoading: isLoading ?? this.isLoading,
      professional: professional ?? this.professional,
    );
  }
}
