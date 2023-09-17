import 'package:brasil_fields/brasil_fields.dart';
import 'package:formz/formz.dart';

enum CpfValidationError { empty, invalid }

class Cpf extends FormzInput<String, CpfValidationError> {
  const Cpf.pure() : super.pure('');
  const Cpf.dirty([super.value = '']) : super.dirty();

  @override
  CpfValidationError? validator(String value) {
    if (value.isEmpty) {
      return CpfValidationError.empty;
    } else if (!CPFValidator.isValid(value)) {
      return CpfValidationError.invalid;
    }
    return null;
  }
}
