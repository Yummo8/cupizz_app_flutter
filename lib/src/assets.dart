const _FLARE_PATH = 'assets/flares/';
const _IMAGE_PATH = 'assets/images/';
const _ICON_PATH = 'assets/icons/';

class Assets {
  static _Flares flares = _Flares();
  static _Icon icons = _Icon();
  static _Image images = _Image();
}

class _Flares {
  final splashScreen = _FLARE_PATH + 'splash_screen.flr';
  final logo = _FLARE_PATH + 'logo.flr';
}

class _Icon {
  final facebook = _ICON_PATH + 'facebook.png';
  final google = _ICON_PATH + 'google.png';
}

class _Image {}
