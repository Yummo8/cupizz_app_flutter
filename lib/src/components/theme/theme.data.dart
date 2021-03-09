import 'package:cupizz_app/src/base/base.dart';

ThemeData _themeData(
  Color primary,
  Color secondary, {
  bool isDark = false,
  Color? primaryVariant,
  Color? secondaryVariant,
}) {
  return ThemeData(
      primaryColor: primary,
      accentColor: primary,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: !isDark
          ? ColorScheme.light(
              primary: primary,
              primaryVariant: primaryVariant!,
              secondary: secondary,
              secondaryVariant: secondaryVariant!,
              surface: Color(0xffE5E5E5),
              onSurface: Color(0xff6c6c6c),
            )
          : ColorScheme.dark(
              primary: primary,
              primaryVariant: primaryVariant!,
              secondary: secondary,
              secondaryVariant: secondaryVariant!,
              surface: Color(0xff6c6c6c),
              onSurface: Color(0xffE5E5E5),
            ));
}

final indigoPinkLight = _themeData(
  Color(0xfffb6c6d),
  Color(0xff666f80),
  primaryVariant: Color(0xffdc4444),
  secondaryVariant: Color(0xff147070),
);

final indigoPinkDark = _themeData(
  Color(0xfffb6c6d),
  Color(0xff666f80),
  primaryVariant: Color(0xffdc4444),
  secondaryVariant: Color(0xff147070),
  isDark: true,
);

final tealPurpleLight = _themeData(
  Colors.teal,
  Colors.purple,
  primaryVariant: Colors.tealAccent,
  secondaryVariant: Colors.purpleAccent,
);

final tealPurpleDark = _themeData(
  Colors.teal,
  Colors.purple,
  primaryVariant: Colors.tealAccent,
  secondaryVariant: Colors.purpleAccent,
  isDark: true,
);

final yellowBlueLight = _themeData(
  Color(0xffffb300),
  Color(0xff1e4bff),
  primaryVariant: Color(0xffa77500),
  secondaryVariant: Color(0xff001672),
);

final yellowBlueDark = _themeData(
  Color(0xffffb300),
  Color(0xff1e4bff),
  primaryVariant: Color(0xffa77500),
  secondaryVariant: Color(0xff001672),
  isDark: true,
);
