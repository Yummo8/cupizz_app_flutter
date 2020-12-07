part of '../answer_question_screen.dart';

Widget _customIcon(
  BuildContext context, {
  int icon,
  bool isEnable = false,
  double size = 18,
  bool istwitterIcon = true,
  bool isFontAwesomeRegular = false,
  bool isFontAwesomeSolid = false,
  Color iconColor,
  double paddingIcon = 10,
}) {
  iconColor = iconColor ?? Theme.of(context).textTheme.caption.color;
  return Padding(
    padding: EdgeInsets.only(bottom: istwitterIcon ? paddingIcon : 0),
    child: Icon(
      IconData(icon,
          fontFamily: istwitterIcon
              ? 'TwitterIcon'
              : isFontAwesomeRegular
                  ? 'AwesomeRegular'
                  : isFontAwesomeSolid
                      ? 'AwesomeSolid'
                      : 'Fontello'),
      size: size,
      color: isEnable ? Theme.of(context).primaryColor : iconColor,
    ),
  );
}

Widget _customInkWell({
  Widget child,
  BuildContext context,
  Function(bool, int) function1,
  Function onPressed,
  bool isEnable = false,
  int no = 0,
  Color color = Colors.transparent,
  Color splashColor,
  BorderRadius radius,
}) {
  splashColor ??= Theme.of(context).primaryColorLight;
  radius ??= BorderRadius.circular(0);
  return Material(
    color: color,
    child: InkWell(
      borderRadius: radius,
      onTap: () {
        if (function1 != null) {
          function1(isEnable, no);
        } else if (onPressed != null) {
          onPressed();
        }
      },
      splashColor: splashColor,
      child: child,
    ),
  );
}
