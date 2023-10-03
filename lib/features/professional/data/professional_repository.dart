import 'package:agendai/core/helpers/result.dart';
import 'package:agendai/features/professional/data/professional_datasource.dart';
import 'package:agendai/features/professional/models/professional_details.dart';
import 'package:agendai/features/professional/models/rating.dart';

class ProfessionalRepository {
  ProfessionalRepository(this._datasource);

  final ProfessionalDatasource _datasource;

  Future<Result<void, ProfessionalDetails>> getProfessional(
      {required String id}) {
    return _datasource.getProfessional(id: id);
  }

  Future<Result<void, List<Rating>>> getProfessionalRatings({
    required String professionalId,
    required int itemsPerPage,
    required int page,
  }) {
    return _datasource.getProfessionalRatings(
      professionalId: professionalId,
      itemsPerPage: itemsPerPage,
      page: page,
    );
  }
}
