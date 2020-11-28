part of '../index.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final PreferredSizeWidget bottom;
  final String title;
  final Function onBackPressed;
  final bool isRouterServicePop;

  BackAppBar({
    Key key,
    this.actions,
    this.bottom,
    this.title,
    this.onBackPressed,
    this.isRouterServicePop = true,
  })  : preferredSize = Size.fromHeight(
            56.0 + (bottom != null ? bottom.preferredSize.height : 0)),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorScheme.background,
      elevation: 4,
      centerTitle: true,
      bottom: bottom,
      shadowColor: context.colorScheme.surface,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: context.colorScheme.onBackground,
        ),
        onPressed: () {
          if (onBackPressed == null) {
            if (isRouterServicePop) {
              RouterService.pop(context);
            } else {
              Navigator.pop(context);
            }
          } else {
            onBackPressed();
          }
        },
      ),
      title: Text(
        title ?? 'Cupizz',
        style: context.textTheme.headline6
            .copyWith(color: context.colorScheme.onBackground),
      ),
      actions: actions,
    );
  }
}
