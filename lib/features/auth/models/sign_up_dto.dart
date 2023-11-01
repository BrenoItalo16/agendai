class SignUpDto {
  const SignUpDto({
    required this.fullName,
    required this.cpf,
    required this.cellPhone,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String cpf;
  final String cellPhone;
  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullName,
      'document': cpf,
      'phone': cellPhone,
      'email': email,
      'password': password,
    };
  }
}
