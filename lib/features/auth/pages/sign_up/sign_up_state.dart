part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    required this.fullName,
    required this.cpf,
    required this.cellPhone,
    required this.password,
    required this.email,
    required this.isLoading,
  });

  const SignUpState.empty()
      : fullName = const FullName.pure(),
        cpf = const Cpf.pure(),
        cellPhone = const CellPhone.pure(),
        password = const Password.pure(),
        email = const Email.pure(),
        isLoading = false;

  final FullName fullName;
  final Cpf cpf;
  final CellPhone cellPhone;
  final Email email;
  final Password password;

  final bool isLoading;

  bool get isValid => Formz.validate([
        fullName,
        cpf,
        cellPhone,
        email,
        password,
      ]);

  @override
  List<Object> get props =>
      [fullName, cpf, cellPhone, email, password, isLoading];

  SignUpState copyWith({
    FullName? fullName,
    Cpf? cpf,
    CellPhone? cellPhone,
    Email? email,
    Password? password,
    bool? isLoading,
  }) {
    return SignUpState(
      fullName: fullName ?? this.fullName,
      cpf: cpf ?? this.cpf,
      cellPhone: cellPhone ?? this.cellPhone,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
