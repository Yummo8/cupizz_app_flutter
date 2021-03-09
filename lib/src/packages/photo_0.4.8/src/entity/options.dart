import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import '../delegate/badge_delegate.dart';
import '../delegate/checkbox_builder_delegate.dart';
import '../delegate/loading_delegate.dart';
import '../delegate/sort_delegate.dart';

class Options {
  const Options({
    this.rowCount,
    this.maxSelected,
    this.padding,
    this.itemRadio,
    this.themeColor,
    this.dividerColor,
    this.textColor,
    this.disableColor,
    this.thumbSize,
    this.sortDelegate,
    this.checkBoxBuilderDelegate,
    this.loadingDelegate,
    this.badgeDelegate,
    this.pickType,
    this.autoCloseOnSelectionLimit,
    this.isCropImage,
    this.cropAspectRatio,
  });

  final int? rowCount;

  final int? maxSelected;

  final double? padding;

  final double? itemRadio;

  final Color? themeColor;

  final Color? dividerColor;

  final Color? textColor;

  final Color? disableColor;

  final int? thumbSize;

  final SortDelegate? sortDelegate;

  final CheckBoxBuilderDelegate? checkBoxBuilderDelegate;

  final LoadingDelegate? loadingDelegate;

  final BadgeDelegate? badgeDelegate;

  final PickType? pickType;

  final bool? autoCloseOnSelectionLimit;

  final bool? isCropImage;

  final CropAspectRatio? cropAspectRatio;
}

enum PickType {
  all,
  onlyImage,
  onlyVideo,
}
