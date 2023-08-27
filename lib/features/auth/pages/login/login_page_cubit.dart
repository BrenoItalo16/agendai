import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(const LoginPageState());

  Future<void> login() async {
    emit(state.copyWith(status: LoginPageStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: LoginPageStatus.success));
  }

  void onEmailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(password: value));
  }
}
