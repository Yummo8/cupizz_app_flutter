import 'package:badges/badges.dart';
import 'package:cupizz_app/src/base/base.dart';

class OpacityIconButton extends StatelessWidget {
  final IconData icon;
  final Widget iconWidget;
  final Function onPressed;
  final EdgeInsets padding;
  final int badgeNumber;

  const OpacityIconButton({
    Key key,
    this.onPressed,
    this.icon,
    this.iconWidget,
    this.padding = const EdgeInsets.all(10),
    this.badgeNumber = 0,
  })  : assert(icon != null || iconWidget != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding,
      color: Colors.transparent,
      child: Badge(
        badgeColor: Colors.red.shade100,
        elevation: 0,
        showBadge: badgeNumber > 0,
        badgeContent: Text(
          badgeNumber.toString(),
          style: context.textTheme.caption.copyWith(color: Colors.red.shade900),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.onPrimary.withOpacity(0.2),
          ),
          child: iconWidget ??
              Icon(
                icon,
                color: context.colorScheme.onPrimary,
              ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
