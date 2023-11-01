import 'package:agendai/core/helpers/result.dart';
import 'package:agendai/features/scheduling/data/scheduling_datasource.dart';
import 'package:agendai/features/scheduling/models/day_slots.dart';
import 'package:agendai/features/scheduling/models/scheduling.dart';

class SchedulingRepository {
  SchedulingRepository(this._datasource);

  final SchedulingDatasource _datasource;

  Future<Result<void, List<Scheduling>>> getUserSchedules() {
    return _datasource.getUserSchedules();
  }

  Future<Result<void, List<DaySlots>>> getSchedulingSlots({
    required int duration,
    required String professionalId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _datasource.getSchedulingSlots(
      duration: duration,
      professionalId: professionalId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
