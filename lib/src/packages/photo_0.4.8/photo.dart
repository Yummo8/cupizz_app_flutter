library photo;

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_manager/photo_manager.dart';

import 'src/delegate/badge_delegate.dart';
import 'src/delegate/checkbox_builder_delegate.dart';
import 'src/delegate/loading_delegate.dart';
import 'src/delegate/sort_delegate.dart';
import 'src/entity/options.dart';
import 'src/provider/i18n_provider.dart';
import 'src/ui/dialog/not_permission_dialog.dart';
import 'src/ui/photo_app.dart';

export 'src/delegate/badge_delegate.dart';
export 'src/delegate/checkbox_builder_delegate.dart';
export 'src/delegate/loading_delegate.dart';
export 'src/delegate/sort_delegate.dart';
export 'src/entity/options.dart' show PickType;
export 'src/provider/i18n_provider.dart'
    show I18NCustomProvider, I18nProvider, VNProvider, ENProvider;

class PhotoPicker {
  factory PhotoPicker() {
    _instance ??= PhotoPicker._();
    return _instance!;
  }

  PhotoPicker._();

  static PhotoPicker? _instance;

  static const String rootRouteName = 'photo_picker_image';

  static Future<List<File>?> pickAsset({
    required BuildContext context,
    int rowCount = 4,
    int maxSelected = 9,
    double padding = 0.5,
    double itemRadio = 1.0,
    Color? themeColor,
    Color? dividerColor,
    Color? textColor,
    Color? disableColor,
    int thumbSize = 64,
    I18nProvider provider = I18nProvider.vietnamese,
    SortDelegate? sortDelegate,
    CheckBoxBuilderDelegate? checkBoxBuilderDelegate,
    LoadingDelegate? loadingDelegate,
    PickType pickType = PickType.all,
    BadgeDelegate badgeDelegate = const DefaultBadgeDelegate(),
    List<AssetPathEntity>? photoPathList,
    List<AssetEntity>? pickedAssetList,
    bool autoCloseOnSelectionLimit = false,
    bool isCropImage = true,
    CropAspectRatio? cropAspectRatio,
  }) {
    themeColor ??= Theme.of(context).primaryColor;
    dividerColor ??= Theme.of(context).dividerColor;
    disableColor ??= Theme.of(context).disabledColor;
    textColor ??= Colors.white;

    sortDelegate ??= SortDelegate.common;
    checkBoxBuilderDelegate ??= DefaultCheckBoxBuilderDelegate();

    loadingDelegate ??= DefaultLoadingDelegate();

    final options = Options(
      rowCount: rowCount,
      dividerColor: dividerColor,
      maxSelected: maxSelected,
      itemRadio: itemRadio,
      padding: padding,
      disableColor: disableColor,
      textColor: textColor,
      themeColor: themeColor,
      thumbSize: thumbSize,
      sortDelegate: sortDelegate,
      checkBoxBuilderDelegate: checkBoxBuilderDelegate,
      loadingDelegate: loadingDelegate,
      badgeDelegate: badgeDelegate,
      pickType: pickType,
      autoCloseOnSelectionLimit: autoCloseOnSelectionLimit,
      isCropImage: isCropImage,
      cropAspectRatio: cropAspectRatio,
    );

    return PhotoPicker()._pickAsset(
      context,
      options,
      provider,
      photoPathList,
      pickedAssetList,
    );
  }

  Future<List<File>?> _pickAsset(
    BuildContext context,
    Options options,
    I18nProvider provider,
    List<AssetPathEntity>? photoList,
    List<AssetEntity>? pickedAssetList,
  ) async {
    final requestPermission = await PhotoManager.requestPermission();
    if (requestPermission != true) {
      final result = await showDialog(
        context: context,
        builder: (ctx) => NotPermissionDialog(
          provider.getNotPermissionText(options),
        ),
      );
      if (result == true) {
        PhotoManager.openSetting();
      }
      return null;
    }

    return _openGalleryContentPage(
      context,
      options,
      provider,
      photoList,
      pickedAssetList,
    );
  }

  Future<List<File>?> _openGalleryContentPage(
    BuildContext context,
    Options options,
    I18nProvider provider,
    List<AssetPathEntity>? photoList,
    List<AssetEntity>? pickedAssetList,
  ) async {
    return Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (ctx) => PhotoApp(
          options: options,
          provider: provider,
          photoList: photoList,
          pickedAssetList: pickedAssetList,
        ),
      ),
    );
  }
}
