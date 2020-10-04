import 'package:email_validator/email_validator.dart';

String userNameValidation(String name) {
  if (name.isEmpty)
    return 'Invalid username';
  else
    return null;
}

String  emailValidation(email) =>
    EmailValidator.validate(email) ? null : 'not a valid email';

String passwordValidation(String password) {
  if (password.length < 5) {
    return 'password too short';
  } else if (password.contains(' ')) {
    return 'password not properly formatted';
  } else {
    return null;
  }
}
