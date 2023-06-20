import 'package:formz/formz.dart';

class LoopTitle extends FormzInput<String, LoopTitleValidationError> {
  const LoopTitle.pure() : super.pure('');
  const LoopTitle.dirty([super.value = '']) : super.dirty();

  @override
  LoopTitleValidationError? validator(String? value) {
    return null;
  }
}

enum LoopTitleValidationError { invalid }
