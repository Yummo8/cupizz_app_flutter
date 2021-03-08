import 'dart:io';

import 'package:cupizz_app/src/base/base.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void pickImage(
  BuildContext context,
  Function(List<File?>? image) onPickedImage, {
  int maxSelected = 9,
  String? title,
  bool isCropImage = true,
  CropAspectRatio? cropAspectRatio,
}) async {
  FocusScope.of(context).unfocus();
  await Menu(
    getPickImagesMenuItem(
      context,
      onPickedImage,
      maxSelected: maxSelected,
      isCropImage: isCropImage,
      cropAspectRatio: cropAspectRatio,
    ),
    title: title,
    showCancel: true,
  ).show(context);
}

List<MenuItem> getPickImagesMenuItem(
  BuildContext context,
  Function(List<File?>? image) onPickedImage, {
  int maxSelected = 9,
  bool isCropImage = true,
  CropAspectRatio? cropAspectRatio,
}) =>
    [
      MenuItem(
        title: Strings.button.takeAPicture,
        onPressed: () async {
          try {
            File? rawImage = File(
                (await ImagePicker().getImage(source: ImageSource.camera))!
                    .path);

            if (isCropImage) {
              rawImage = await cropImage(context, rawImage, cropAspectRatio);
            }
            onPickedImage([rawImage]);
          } catch (e) {
            await Fluttertoast.showToast(msg: 'Đã xảy ra lỗi.\n$e');
          } finally {
            Navigator.pop(context);
          }
        },
      ),
      MenuItem(
        title: Strings.button.pickFromGallery,
        onPressed: () => PhotoPicker.pickAsset(
          context: context,
          pickType: PickType.onlyImage,
          disableColor: context.colorScheme.onSurface,
          dividerColor: context.colorScheme.background,
          textColor: context.colorScheme.primary,
          themeColor: context.colorScheme.background,
          maxSelected: maxSelected,
          isCropImage: isCropImage,
          cropAspectRatio: cropAspectRatio,
        ).then((assets) async {
          if (assets.isExistAndNotEmpty) {
            onPickedImage(assets);
          }
        }).whenComplete(() => Navigator.pop(context)),
      ),
    ];

Future<File?> cropImage(BuildContext context, File image,
        [CropAspectRatio? ratio]) =>
    ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: ratio,
      compressQuality: 100,
      maxWidth: 1800,
      maxHeight: 1800,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: context.colorScheme.onPrimary,
        toolbarTitle: '',
        statusBarColor: context.colorScheme.onBackground,
        backgroundColor: context.colorScheme.background,
        activeControlsWidgetColor: context.colorScheme.primary,
        cropFrameColor: context.colorScheme.onSurface,
        cropGridColor: context.colorScheme.onSurface,
        dimmedLayerColor: context.colorScheme.background,
        toolbarWidgetColor: context.colorScheme.primary,
      ),
    );
