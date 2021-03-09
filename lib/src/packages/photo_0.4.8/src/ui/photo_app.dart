import 'dart:io';

import 'package:flutter/material.dart';

import 'package:photo_manager/photo_manager.dart';

import '../entity/options.dart';
import '../provider/config_provider.dart';
import '../provider/i18n_provider.dart';
import '../ui/page/photo_main_page.dart';
import './image_cropper_screen.dart';

class PhotoApp extends StatelessWidget {
  const PhotoApp({
    Key? key,
    this.options,
    this.provider,
    this.photoList,
    this.pickedAssetList,
  }) : super(key: key);

  final Options? options;
  final I18nProvider? provider;
  final List<AssetPathEntity>? photoList;
  final List<AssetEntity>? pickedAssetList;

//  final List<AssetEntity> pickedAssetList;

  @override
  Widget build(BuildContext context) {
    final pickerProvider = PhotoPickerProvider(
      provider: provider,
      options: options,
      pickedAssetList: pickedAssetList,
      child: PhotoMainPage(
        onClose: (List<AssetEntity> value) async {
          List<File?>? files;
          if (options!.isCropImage!) {
            final listFile =
                await Future.wait(value.map((e) => e.file).toList());
            files = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImagesCropperScreen(
                        files: listFile,
                        aspectRatio: options!.cropAspectRatio,
                      )),
            );
          } else {
            files = await Future.wait(value.map((e) => e.file).toList());
          }
          if (files != null && files.isNotEmpty) {
            Navigator.pop(context, files);
          }
        },
        options: options,
        photoList: photoList,
      ),
    );

    return pickerProvider;
  }
}
