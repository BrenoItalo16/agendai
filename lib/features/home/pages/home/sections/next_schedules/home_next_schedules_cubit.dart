import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/helpers/result.dart';
import 'package:agendai/features/scheduling/data/scheduling_repository.dart';
import 'package:agendai/features/scheduling/models/scheduling.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_next_schedules_state.dart';

class HomeNextSchedulesCubit extends Cubit<HomeNextSchedulesState> {
  HomeNextSchedulesCubit({SchedulingRepository? repository})
      : _repository = repository ?? getIt(),
        super(const HomeNextSchedulesState.empty());

  final SchedulingRepository _repository;

  Future<void> loadSchedulings() async {
    emit(state.copyWith(status: HomeNextSchedulesStatus.loading));
    final result = await _repository.getUserSchedules();
    (switch (result) {
      Success(:final object) => emit(
          state.copyWith(
            status: HomeNextSchedulesStatus.success,
            schedulings: object,
          ),
        ),
      Failure() => emit(
          state.copyWith(
            status: HomeNextSchedulesStatus.error,
          ),
        ),
    });
  }

  void setUserNotLoggedIn() {
    emit(state.copyWith(status: HomeNextSchedulesStatus.notLoggedIn));
  }
}
