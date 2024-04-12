import 'package:formz/formz.dart';

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class Password extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const Password.pure() : super.pure('');

  /// {@macro password}
  const Password.dirty([super.value = '']) : super.dirty();

  // static final _passwordRegExp =
  //     RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  // RegExp(r'(?!.*[^a-zA-Z0-9]){8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    // return _passwordRegExp.hasMatch(value ?? '')
    //     ? null
    //     : PasswordValidationError.invalid;
    return (value != null && value.isNotEmpty)
        ? null
        : PasswordValidationError.invalid;
  }
}
