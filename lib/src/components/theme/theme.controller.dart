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

  ThemeData selectedTheme() {
    return themes[model.activeTheme];
  }

  List<ThemeData> get themes {
    return [
      indigoPinkLight,
      tealPurpleLight,
      indigoPinkDark,
      tealPurpleDark,
    ];
  }
}
