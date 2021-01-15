import 'package:cupizz_app/src/base/base.dart';

class Menu {
  final String title;
  final List<MenuItem> menuItems;
  final bool showCancel;

  Menu(this.menuItems, {this.showCancel = false, this.title});

  Future<T> show<T>(BuildContext context) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: title.isExistAndNotEmpty
              ? Text(title,
                  style: context.textTheme.headline6.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface))
              : null,
          actions: [
            ...menuItems
                .map(
                  (e) => CupertinoActionSheetAction(
                    onPressed: e.onPressed,
                    child: Text(e.title),
                    isDefaultAction: e.isDefaultAction,
                    isDestructiveAction: e.isDestructiveAction,
                  ),
                )
                .toList(),
          ],
          cancelButton: !showCancel
              ? null
              : CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(Strings.button.cancel),
                  isDestructiveAction: true,
                ),
        );
      },
    );
  }
}

class MenuItem {
  final String title;
  final Function onPressed;
  final bool isDefaultAction;
  final bool isDestructiveAction;

  MenuItem({
    @required this.title,
    @required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
  });
}

class ViewImageMenuItem extends MenuItem {
  ViewImageMenuItem(BuildContext context, List<FileModel> images,
      {String title})
      : super(
          title: title ?? 'Xem ảnh',
          onPressed: () {
            PhotoViewDialog(context, images: images).show();
          },
        );
}
