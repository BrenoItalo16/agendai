import 'package:agendai/core/alert/alert_area_cubit.dart';
import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/helpers/result.dart';
import 'package:agendai/features/auth/data/auth_repository.dart';
import 'package:agendai/features/auth/models/cellphone.dart';
import 'package:agendai/features/auth/models/cpf.dart';
import 'package:agendai/features/auth/models/email.dart';
import 'package:agendai/features/auth/models/full_name.dart';
import 'package:agendai/features/auth/models/password.dart';
import 'package:agendai/features/auth/models/sign_up_dto.dart';
import 'package:agendai/features/auth/pages/sign_up/sign_up_actions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._actions,
      {AuthRepository? authRepository, AlertAreaCubit? alertAreaCubit})
      : _authRepository = authRepository ?? getIt(),
        _alertAreaCubit = alertAreaCubit ?? getIt(),
        super(const SignUpState.empty());

  final SignUpActions _actions;

  final AuthRepository _authRepository;
  final AlertAreaCubit _alertAreaCubit;

  void onFullNameChanged(String s) {
    emit(state.copyWith(fullName: FullName.dirty(s)));
  }

  void onCpfChanged(String s) {
    emit(state.copyWith(cpf: Cpf.dirty(s)));
  }

  void onCellPhoneChanged(String s) {
    emit(state.copyWith(cellPhone: CellPhone.dirty(s)));
  }

  void onEmailChanged(String s) {
    emit(state.copyWith(email: Email.dirty(s)));
  }

  void onPasswordChanged(String s) {
    emit(state.copyWith(password: Password.dirty(s)));
  }

  Future<void> onSignUpPressed() async {
    emit(state.copyWith(isLoading: true));

    final result = await _authRepository.signUp(
      SignUpDto(
        fullName: state.fullName.value,
        cpf: state.cpf.value,
        cellPhone: state.cellPhone.value,
        email: state.email.value,
        password: state.password.value,
      ),
    );

    switch (result) {
      case Success():
        const Alert.success(
          title: 'Cadastrado com sucesso',
          duration: Duration(seconds: 3),
        );

        _actions.navToHome();
      case Failure():
        _alertAreaCubit.showAlert(
          const Alert.error(
            title:
                'Não foi possível criar sua conta! Por favor, tente novamente.',
            duration: Duration(seconds: 3),
          ),
        );
    }

    emit(state.copyWith(isLoading: false));
  }
}
