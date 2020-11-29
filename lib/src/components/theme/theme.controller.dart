part of '../index.dart';

class ThemeController extends MomentumController<ThemeModel> {
  StorageService _storage;

  @override
  ThemeModel init() {
    _storage = getService<StorageService>();
    _storage.getTheme.then((value) {
      model.update(activeTheme: value ?? 0);
    });
    return ThemeModel(
      this,
      activeTheme: 0,
    );
  }

  void selectTheme(int index) => _selectTheme(index);

  void randomTheme() => _selectTheme(Random().nextInt(themes.length));

  void _selectTheme(int index) {
    _storage.saveTheme(index);
    model.update(activeTheme: index);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: themes[index].brightness,
        statusBarColor: themes[index].colorScheme.onBackground.withOpacity(0),
        statusBarIconBrightness: themes[index].brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );
  }

  ThemeData get selectedTheme => themes[model.activeTheme];

  List<ThemeData> get themes {
    return [
      indigoPinkLight,
      indigoPinkDark,
      tealPurpleLight,
      tealPurpleDark,
      yellowBlueLight,
      yellowBlueDark
    ];
  }
}
