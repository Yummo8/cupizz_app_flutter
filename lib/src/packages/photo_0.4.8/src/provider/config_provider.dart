import 'package:flutter/material.dart';
import '../entity/options.dart';
import 'asset_provider.dart';
import 'i18n_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoPickerProvider extends InheritedWidget {
  final Options options;
  final I18nProvider provider;
  final AssetProvider assetProvider = AssetProvider();
  final List<AssetEntity> pickedAssetList;
  PhotoPickerProvider({
    @required this.options,
    @required this.provider,
    @required Widget child,
    this.pickedAssetList,
    Key key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static PhotoPickerProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PhotoPickerProvider>(
          aspect: PhotoPickerProvider);

  static AssetProvider assetProviderOf(BuildContext context) =>
      of(context).assetProvider;
}
