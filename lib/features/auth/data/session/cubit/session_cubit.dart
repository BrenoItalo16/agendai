import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/helpers/result.dart';
import 'package:agendai/features/auth/data/auth_repository.dart';
import 'package:agendai/features/auth/data/results/login_failed.dart';
import 'package:agendai/features/auth/data/results/sign_up_failed.dart';
import 'package:agendai/features/auth/data/results/validate_token_failed.dart';
import 'package:agendai/features/auth/models/sign_up_dto.dart';
import 'package:agendai/features/auth/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? getIt(),
        super(const SessionState());

  final AuthRepository _authRepository;

  Future<Result<LoginFailed, User>> login(
      {required String email, required String password}) async {
    final result = await _authRepository.login(
      email: email,
      password: password,
    );
    if (result case Success(object: final user)) {
      emit(state.copyWith(loggedUser: user));
    }
    return result;
  }

  Future<Result<SignUpFailed, User>> signUp(SignUpDto signUpDto) async {
    final result = await _authRepository.signUp(signUpDto);
    if (result case Success(object: final user)) {
      emit(state.copyWith(loggedUser: user));
    }
    return result;
  }

  Future<Result<ValidateTokenFailed, User>> validateToken() async {
    final result = await _authRepository.validateToken();

    if (result case Success(object: final user)) {
      emit(state.copyWith(loggedUser: user));
    }
    return result;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(const SessionState(loggedUser: null));
  }
}
