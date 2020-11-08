part of '../index.dart';

// TODO change color onSurface and surface for bright and dark theme
ThemeData _themeData(
  Color primary,
  Color secondary, {
  bool isDark = false,
  Color primaryVariant,
  Color secondaryVariant,
}) =>
    ThemeData(
        primaryColor: primary,
        accentColor: secondary,
        colorScheme: !isDark
            ? ColorScheme.light(
                primary: primary,
                primaryVariant: primaryVariant,
                secondary: secondary,
                secondaryVariant: secondaryVariant,
              )
            : ColorScheme.dark(
                primary: primary,
                primaryVariant: primaryVariant,
                secondary: secondary,
                secondaryVariant: secondaryVariant,
              ));

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
