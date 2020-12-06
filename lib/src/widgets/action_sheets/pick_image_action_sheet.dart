part of '../index.dart';

void pickImage(BuildContext context, Function(List<File> image) onPickedImage,
    {int maxSelected = 9, String title}) async {
  FocusScope.of(context).unfocus();
  await Menu(
    getPickImagesMenuItem(context, onPickedImage, maxSelected: maxSelected),
    title: title,
    showCancel: true,
  ).show(context);
}

List<MenuItem> getPickImagesMenuItem(
  BuildContext context,
  Function(List<File> image) onPickedImage, {
  int maxSelected = 9,
}) =>
    [
      MenuItem(
        title: Strings.button.takeAPicture,
        onPressed: () => ImagePicker()
            .getImage(source: ImageSource.camera)
            .then((image) async {
          onPickedImage([File(image.path)]);
        }).whenComplete(() => Navigator.pop(context)),
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
        ).then((assets) async {
          if (assets.isNotEmpty) {
            onPickedImage(assets);
          }
        }).whenComplete(() => Navigator.pop(context)),
      ),
    ];
