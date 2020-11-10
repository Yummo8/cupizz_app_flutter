part of 'index.dart';

class Strings {
  static const APP_TITLE = 'Invite me';
  static const INVITE_ME_TEXT_DATA = '@invite_me';
  static final _Common common = _Common();
  static final _Button button = _Button();
  static final _Error error = _Error();
  static final _Drawer drawer = _Drawer();
  static final _LoginScreen login = _LoginScreen();
  static final _RegisterScreen register = _RegisterScreen();
}

class _Common {
  final email = 'Email';
  final password = 'Mật khẩu';
  final name = 'Tên';
  final hobbies = 'Sở thích';
  final distance = 'Khoảng cách';
  final age = 'Tuổi';
  final man = 'Nam';
  final woman = 'Nữ';
  final other = 'Khác';
}

class _Error {
  final unknownError = 'Lỗi không xác định';
  final invalidEmail = 'Email không đúng định dạng';
  final invalidPassword = 'Mật khẩu phải lớn hơn 8 ký tự';
  final errorClick = 'Đã xảy ra lỗi. Click để xem chi tiết.';
  final error = 'Đã xảy ra lỗi.';
}

class _Button {
  final login = "Đăng nhập";
  final register = 'Đăng ký';
  final forgotPassword = 'Quên mật khẩu?';
  final reload = 'Tải lại';
}

class _LoginScreen {
  final dontHaveAccount = 'Bạn chưa có tài khoản?';
  final registerNow = 'Đăng ký ngay';
}

class _RegisterScreen {
  final haveAccount = 'Đã có tài khoản';
  final loginNow = 'Đăng nhập ngay';
}

class _Drawer {
  final filter = 'Bộ lọc tìm kiếm';
  final whoAreYouLookingFor = 'Giới tính của người bạn cần tìm?';
  final upTo5Pieces = 'Tối đa 5 sở thích';
  final chooseOtherHoddies = 'Chọn sở thích khác';
}
