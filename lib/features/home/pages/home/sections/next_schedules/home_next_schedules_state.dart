part of 'home_next_schedules_cubit.dart';

enum HomeNextSchedulesStatus { notLoggedIn, loading, success, error }

class HomeNextSchedulesState extends Equatable {
  const HomeNextSchedulesState({
    required this.status,
    required this.schedulings,
  });

  const HomeNextSchedulesState.empty()
      : schedulings = null,
        status = HomeNextSchedulesStatus.loading;

  final List<Scheduling>? schedulings;
  final HomeNextSchedulesStatus status;

  @override
  List<Object?> get props => [schedulings, status];

  HomeNextSchedulesState copyWith({
    List<Scheduling>? schedulings,
    HomeNextSchedulesStatus? status,
  }) {
    return HomeNextSchedulesState(
      schedulings: schedulings ?? this.schedulings,
      status: status ?? this.status,
    );
  }
}
