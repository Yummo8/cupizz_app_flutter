import 'dart:math';

import 'package:cubizz_app/src/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import './theme.data.dart';

import 'index.dart';

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
