part of 'index.dart';

class Strings {
  static const APP_TITLE = 'Invite me';
  static const INVITE_ME_TEXT_DATA = '@invite_me';
  static final _Common common = _Common();
  static final _Button button = _Button();
  static final _Error error = _Error();
  static final _LoginScreen login = _LoginScreen();
  static final _RegisterScreen register = _RegisterScreen();
}

class _Common {
  final email = 'Email';
  final password = 'Mật khẩu';
  final name = 'Tên';
}

class _Error {
  final unknownError = 'Lỗi không xác định';
  final invalidEmail = 'Email không đúng định dạng';
  final invalidPassword = 'Mật khẩu phải lớn hơn 8 ký tự';
}

class _Button {
  final login = "Đăng nhập";
  final register = 'Đăng ký';
  final forgotPassword = 'Quên mật khẩu?';
}

class _LoginScreen {
  final dontHaveAccount = 'Bạn chưa có tài khoản?';
  final registerNow = 'Đăng ký ngay';
}

class _RegisterScreen {
  final haveAccount = 'Đã có tài khoản';
  final loginNow = 'Đăng nhập ngay';
}
