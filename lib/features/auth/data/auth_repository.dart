import 'package:agendai/core/device/app_secure_storage.dart';
import 'package:agendai/core/helpers/result.dart';
import 'package:agendai/features/auth/data/results/sign_up_failed.dart';
import 'package:agendai/features/auth/models/sign_up_dto.dart';
import 'package:agendai/features/auth/models/user.dart';
import 'auth_datasource.dart';
import 'results/login_failed.dart';
import 'results/validate_token_failed.dart';

class AuthRepository {
  AuthRepository(this._datasource, this._appSecureStorage);

  final AuthDatasource _datasource;

  final AppSecureStorage _appSecureStorage;

  Future<Result<LoginFailed, User>> login(
      {required String email, required String password}) async {
    final result = await _datasource.login(email: email, password: password);
    if (result case Success(object: final user)) {
      await _appSecureStorage.saveSessionToken(user.token);
    }
    return result;
  }

  Future<Result<SignUpFailed, User>> signUp(SignUpDto signUpDto) async {
    final result = await _datasource.signUp(signUpDto);
    if (result case Success(object: final user)) {
      await _appSecureStorage.saveSessionToken(user.token);
    }
    return result;
  }

  Future<Result<ValidateTokenFailed, User>> validateToken() async {
    final token = await _appSecureStorage.getSessionToken();
    if (token == null) {
      return const Failure(ValidateTokenFailed.invalidToken);
    }
    return _datasource.validateToken(token);
  }

  Future<void> logout() {
    return _appSecureStorage.deleteSessionToken();
  }
}
