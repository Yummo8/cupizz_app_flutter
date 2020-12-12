part of '../index.dart';

class OpacityIconButton extends StatelessWidget {
  final IconData icon;
  final Widget iconWidget;
  final Function onPressed;

  const OpacityIconButton({Key key, this.onPressed, this.icon, this.iconWidget})
      : assert(icon != null || iconWidget != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.all(10),
      color: Colors.transparent,
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
      onPressed: onPressed,
    );
  }
}
