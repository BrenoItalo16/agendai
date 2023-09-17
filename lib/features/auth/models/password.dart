import 'package:formz/formz.dart';

enum PasswordValidationError { empty, tooShort }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure({this.validateLength = true}) : super.pure('');
  const Password.dirty([super.value = '', this.validateLength = true])
      : super.dirty();

  final bool validateLength;

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.length < 8 && validateLength) {
      return PasswordValidationError.tooShort;
    }
    return null;
  }
}
