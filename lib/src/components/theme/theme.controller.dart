import 'dart:math';

import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import './theme.data.dart';

import 'index.dart';

class ThemeController extends MomentumController<ThemeModel> {
  @override
  ThemeModel init() {
    return ThemeModel(
      this,
      activeTheme: 0,
    );
  }

  void selectTheme(int index) {
    model.update(activeTheme: index);
  }

  void randomTheme() {
    model.update(activeTheme: Random().nextInt(themes.length));
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
