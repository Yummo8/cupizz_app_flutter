part of 'index.dart';

class Validator {
  static String email(String email) {
    if (!email.isEmail) {
      return Strings.error.invalidEmail;
    }
    return null;
  }

  static String password(String value) {
    if (value.length < 8) {
      return Strings.error.invalidPassword;
    }
    return null;
  }
}
