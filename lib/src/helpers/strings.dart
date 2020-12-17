part of 'index.dart';

class Strings {
  static const APP_TITLE = 'Cupizz';
  static final _Common common = _Common();
  static final _Public public = _Public();
  static final _Button button = _Button();
  static final _Error error = _Error();
  static final _Drawer drawer = _Drawer();
  static final _LoginScreen login = _LoginScreen();
  static final _RegisterScreen register = _RegisterScreen();
  static final _FriendPage friendPage = _FriendPage();
  static final _MessageScreen messageScreen = _MessageScreen();
  static final _EditProfileScreen editProfile = _EditProfileScreen();
}

class _Common {
  final inDeveloping = 'Tính năng đang phát triển';
  final email = 'Email';
  final password = 'Mật khẩu';
  final oldPassword = 'Mật khẩu cũ';
  final newPassword = 'Mật khẩu mới';
  final name = 'Tên';
  final hobbies = 'Sở thích';
  final distance = 'Khoảng cách';
  final age = 'Tuổi';
  final height = 'Chiều cao';
  final gender = 'Giới tính';
  final man = 'Nam';
  final woman = 'Nữ';
  final other = 'Khác';
  final image = 'Hình ảnh';
  final showOnYourProfile = 'Hiển thị trên hồ sơ của bạn';
  final birthday = 'Ngày sinh';
  final notDisclose = 'Không muốn tiết lộ';
}

class _Public {
  final updateCover = 'Cập nhật ảnh bìa';
  final updateAvatar = 'Đổi avatar';
}

class _Error {
  final unknownError = 'Lỗi không xác định';
  final invalidEmail = 'Email không đúng định dạng';
  final invalidName = 'Hãy điền tên dài hơn';
  final invalidPassword = 'Mật khẩu phải lớn hơn 8 ký tự';
  final invalidUserAnswer = 'Câu trả lời phải nhiều hơn 10 ký tự';
  final errorClick = 'Đã xảy ra lỗi. Click để xem chi tiết.';
  final error = 'Đã xảy ra lỗi.';
}

class _Button {
  final login = 'Đăng nhập';
  final register = 'Đăng ký';
  final forgotPassword = 'Quên mật khẩu?';
  final reload = 'Tải lại';
  final hide = 'Ẩn';
  final hideConversation = 'Ẩn tin nhắn';
  final delete = 'Xóa';
  final takeAPicture = 'Chụp ảnh';
  final pickFromGallery = 'Chọn từ thư viện';
  final cancel = 'Hủy bỏ';
  final save = 'Lưu';
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
  final filter = 'Mẫu người bạn thích';
  final whoAreYouLookingFor = 'Giới tính là ...';
  final upTo5Pieces = 'Tối đa 5 sở thích';
  final chooseOtherHoddies = 'Chọn sở thích khác';
}

class _FriendPage {
  final title = 'Yêu thích';
  final filterTitle = 'Bộ lọc';
  final sortTitle = 'Sắp xếp';
}

class _MessageScreen {
  final hint = 'Nhập tin nhắn';
  String lastOnlineAt(String time) => 'Truy cập $time';
}

class _EditProfileScreen {
  final title = 'Chỉnh sửa hồ sơ hẹn hò';
  final introduction = 'Giới thiệu bản thân';
}
