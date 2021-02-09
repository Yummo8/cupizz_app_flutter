const _FLARE_PATH = 'assets/flares/';
const _IMAGE_PATH = 'assets/images/';
const _ICON_PATH = 'assets/icons/';
const _GIF_PATH = 'assets/gifs/';

class Assets {
  static const flares = _Flares();
  static const icons = _Icon();
  static const images = _Image();
  static const gifs = _Gif();
}

class _Flares {
  const _Flares();
  final splashScreen = _FLARE_PATH + 'splash_screen.flr';
  final logo = _FLARE_PATH + 'logo.flr';
  final brokenHeart = _FLARE_PATH + 'broken_heart.flr';
  final otp = _FLARE_PATH + 'otp.flr';
}

class _Icon {
  const _Icon();
  final facebook = _ICON_PATH + 'facebook.png';
  final google = _ICON_PATH + 'google.png';
  final likeUser = _ICON_PATH + 'like_user.svg';
  final dislikeUser = _ICON_PATH + 'dislike_user.svg';
  final star = _ICON_PATH + 'star.svg';
  final like = _ICON_PATH + 'like.svg';
  final love = _ICON_PATH + 'love.svg';
  final wow = _ICON_PATH + 'wow.svg';
  final haha = _ICON_PATH + 'haha.svg';
  final angry = _ICON_PATH + 'angry.svg';
  final sad = _ICON_PATH + 'sad.svg';
}

class _Gif {
  const _Gif();
  final like = _GIF_PATH + 'like.gif';
  final love = _GIF_PATH + 'love.gif';
  final wow = _GIF_PATH + 'wow.gif';
  final haha = _GIF_PATH + 'haha.gif';
  final angry = _GIF_PATH + 'angry.gif';
  final sad = _GIF_PATH + 'sad.gif';
}

class _Image {
  const _Image();
  final defaultAvatar = _IMAGE_PATH + 'default_avatar.png';
}
