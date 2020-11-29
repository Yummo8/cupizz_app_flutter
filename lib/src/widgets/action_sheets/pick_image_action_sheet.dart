part of '../index.dart';

void pickImage(BuildContext context, Function(List<File> image) onPickedImage,
    {bool isMulti = false, String title}) async {
  FocusScope.of(context).unfocus();
  await showCupertinoModalPopup(
    context: context,
    useRootNavigator: false,
    builder: (context) => CupertinoActionSheet(
      title: Text(title,
          style: context.textTheme.headline6.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface)),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () => ImagePicker()
              .getImage(source: ImageSource.camera)
              .then((image) async {
            onPickedImage([File(image.path)]);
          }).whenComplete(() => Navigator.pop(context)),
          child: Text(
            Strings.button.takeAPicture,
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () => PhotoPicker.pickAsset(
            context: context,
            pickType: PickType.onlyImage,
            disableColor: context.colorScheme.onSurface,
            dividerColor: context.colorScheme.background,
            textColor: context.colorScheme.primary,
            themeColor: context.colorScheme.background,
          ).then((assets) async {
            if (assets.isNotEmpty) {
              final files = await Future.wait(assets.map((e) => e.file));
              onPickedImage(files);
            }
          }).whenComplete(() => Navigator.pop(context)),
          child: Text(
            Strings.button.pickFromGallery,
          ),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        isDestructiveAction: true,
        child: Text(
          Strings.button.cancel,
        ),
      ),
    ),
  );
}
