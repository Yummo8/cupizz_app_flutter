import 'package:cupizz_app/src/base/base.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final PreferredSizeWidget bottom;
  final String title;
  final Widget titleWidget;
  final Function onBackPressed;
  final bool isRouterPop;
  final Color backgroundColor;
  final double elevation;
  final Color shadowColor;
  final Color textColor;
  final bool showBackButton;
  final bool centerTitle;
  final IconData backIcon;

  BackAppBar({
    Key key,
    this.actions,
    this.bottom,
    this.title,
    this.onBackPressed,
    this.isRouterPop = true,
    this.backgroundColor,
    this.elevation = 4,
    this.shadowColor,
    this.textColor,
    this.showBackButton = true,
    this.titleWidget,
    this.centerTitle = true,
    this.backIcon = Icons.arrow_back_ios,
  })  : preferredSize = Size.fromHeight(
            56.0 + (bottom != null ? bottom.preferredSize.height : 0)),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? context.colorScheme.background,
      elevation: elevation,
      centerTitle: centerTitle,
      bottom: bottom,
      shadowColor: shadowColor ?? context.colorScheme.surface,
      leading: !showBackButton
          ? const SizedBox.shrink()
          : IconButton(
              icon: Icon(
                backIcon,
                color: textColor ?? context.colorScheme.onBackground,
              ),
              onPressed: () {
                if (onBackPressed == null) {
                  if (isRouterPop) {
                    Router.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                } else {
                  onBackPressed();
                }
              },
            ),
      title: titleWidget ??
          Text(
            title ?? 'Cupizz',
            style: context.textTheme.headline6
                .copyWith(color: textColor ?? context.colorScheme.onBackground),
          ),
      actions: actions,
    );
  }
}
