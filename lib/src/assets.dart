const String _FLARE_PATH = 'assets/flares/';
const String _IMAGE_PATH = 'assets/images/';
const String _ICON_PATH = 'assets/icons/';

class Assets {
  static Assets i = Assets._();
  factory Assets() => i;
  Assets._();

  _Flares flares = _Flares();
  _Icon icons = _Icon();
  _Image images = _Image();
}

class _Flares {
  final String splashScreen = _FLARE_PATH + 'splash_screen.flr';
  final String logo = _FLARE_PATH + 'logo.flr';
  final String brokenHeart = _FLARE_PATH + 'broken_heart.flr';
}

class _Icon {
  final String facebook = _ICON_PATH + 'facebook.png';
  final String google = _ICON_PATH + 'google.png';
  final String likeUser = _ICON_PATH + 'like_user.svg';
  final String dislikeUser = _ICON_PATH + 'dislike_user.svg';
}

class _Image {
  final String defaultAvatar = _IMAGE_PATH + 'default_avatar.png';
}
