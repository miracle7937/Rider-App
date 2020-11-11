import 'package:email_validator/email_validator.dart';

String userNameValidation(String name) {
  if (name.isEmpty)
    return 'Invalid username';
  else
    return null;
}

String emailValidation(email) => EmailValidator.validate(email)
    ? null
    : 'Please provide a proper formatted email address';

String passwordValidation(String password) {
  if (password.length < 5) {
    return 'password length is too short';
  } else if (password.contains(' ')) {
    return 'Please ensure password is properly formatted';
  } else {
    return null;
  }
}
