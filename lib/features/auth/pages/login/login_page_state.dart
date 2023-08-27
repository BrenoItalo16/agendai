part of 'login_page_cubit.dart';

enum LoginPageStatus { initial, loading, failure, success }

@immutable
class LoginPageState extends Equatable {
  const LoginPageState({
    this.email = '',
    this.password = '',
    this.status = LoginPageStatus.initial,
  });

  final String email;
  final String password;
  final LoginPageStatus status;

  @override
  List<Object?> get props => [email, password, status];

  LoginPageState copyWith({
    String? email,
    String? password,
    LoginPageStatus? status,
  }) {
    return LoginPageState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
