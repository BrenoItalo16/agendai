import 'package:formz/formz.dart';

enum CellPhoneValidationError { empty, invalid }

class CellPhone extends FormzInput<String, CellPhoneValidationError> {
  const CellPhone.pure() : super.pure('');
  const CellPhone.dirty([super.value = '']) : super.dirty();

  @override
  CellPhoneValidationError? validator(String value) {
    if (value.isEmpty) {
      return CellPhoneValidationError.empty;
    } else if (value.length < 13) {
      return CellPhoneValidationError.invalid;
    }
    return null;
  }
}
