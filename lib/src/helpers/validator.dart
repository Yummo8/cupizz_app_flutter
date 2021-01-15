import 'package:cupizz_app/src/base/base.dart';

class Validator {
  static String name(String name) {
    if (name.length < 3) {
      return Strings.error.invalidName;
    }
    return null;
  }

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

  static String userAnswer(String value) {
    if (value.length < 10) {
      return Strings.error.invalidUserAnswer;
    }
    return null;
  }
}
