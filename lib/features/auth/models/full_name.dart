import 'package:formz/formz.dart';

enum FullNameValidationError { empty, incomplete }

class FullName extends FormzInput<String, FullNameValidationError> {
  const FullName.pure() : super.pure('');
  const FullName.dirty([super.value = '']) : super.dirty();

  @override
  FullNameValidationError? validator(String value) {
    if (value.isEmpty) {
      return FullNameValidationError.empty;
    } else if (value.split(' ').length <= 1) {
      return FullNameValidationError.incomplete;
    }
    return null;
  }
}
