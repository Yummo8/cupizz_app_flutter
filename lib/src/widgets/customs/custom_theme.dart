import 'package:flutter/material.dart';

class CustomTheme extends InheritedWidget {
  CustomTheme({
    Key key,
    Widget child,
    @required this.theme,
  }) : super(key: key, child: child);

  final ThemeData theme;

  static ThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomTheme>().theme;
  }

  @override
  bool updateShouldNotify(CustomTheme oldWidget) {
    var notSameTheme = oldWidget.theme != theme;
    return notSameTheme;
  }
}
