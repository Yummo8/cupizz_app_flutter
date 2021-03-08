import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import '../entity/options.dart';
import 'asset_provider.dart';
import 'i18n_provider.dart';

class PhotoPickerProvider extends InheritedWidget {
  PhotoPickerProvider({
    required this.options,
    required this.provider,
    required Widget child,
    this.pickedAssetList,
    Key? key,
  }) : super(key: key, child: child);

  final Options? options;
  final I18nProvider? provider;
  final AssetProvider assetProvider = AssetProvider();
  final List<AssetEntity>? pickedAssetList;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static PhotoPickerProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PhotoPickerProvider>(
          aspect: PhotoPickerProvider);

  static AssetProvider assetProviderOf(BuildContext context) =>
      of(context)!.assetProvider;
}
