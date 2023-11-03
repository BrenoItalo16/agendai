import 'dart:collection';

import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/helpers/result.dart';
import 'package:agendai/features/scheduling/data/scheduling_repository.dart';
import 'package:agendai/features/scheduling/models/scheduling.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'schedulings_page_state.dart';

enum SchedulingsStatus { future, past }

class SchedulingsPageCubit extends Cubit<SchedulingsPageState> {
  SchedulingsPageCubit({
    SchedulingRepository? repository,
    required this.status,
  })  : _repository = repository ?? getIt(),
        super(
          const SchedulingsPageState(),
        );

  final SchedulingsStatus status;
  final SchedulingRepository _repository;

  Future<void> loadSchedulings() async {
    if (state.isLoading && state.schedulings != null) return;

    emit(state.copyWith(isLoading: true));
    final result = await _repository.getUserSchedules(
        state.page, status == SchedulingsStatus.future);
    emit(switch (result) {
      Success(:final object) => state.copyWith(
          schedulings:
              state.page == 0 ? object : [...state.schedulings!, ...object],
          isLoading: false,
          page: state.page + 1,
          finishedLoading: object.length < 20,
        ),
      Failure() => state.copyWith(isLoading: false),
    });
  }
}
