import 'package:cupizz_app/src/constants/values.dart';
import 'package:flutter/material.dart';

class ActionIcon extends StatelessWidget {
  ActionIcon({
    this.iconData,
    this.color = AppColors.grey,
    this.title,
    this.size,
    this.hasTitle = true,
    this.isHorizontal = false,
    this.titleStyle,
    this.onTap,
  }) : assert(hasTitle == false || title != null);

  final IconData iconData;
  final double size;
  final Color color;
  final String title;
  final TextStyle titleStyle;
  final bool hasTitle;
  final bool isHorizontal;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      child: !isHorizontal
          ? Column(
              children: [
                IconButton(
                    icon: Icon(
                      iconData,
                      size: size,
                      color: color,
                    ),
                    onPressed: onTap),
                hasTitle
                    ? InkWell(
                        onTap: onTap,
                        child: Text(
                          title,
                          style: titleStyle ??
                              theme.textTheme.bodyText1.copyWith(
                                  color: AppColors.grey,
                                  fontSize: Sizes.TEXT_SIZE_14),
                        ),
                      )
                    : Container()
              ],
            )
          : Row(
              children: [
                IconButton(
                  padding:  EdgeInsets.zero,
                  icon: Icon(
                    iconData,
                    size: size,
                    color: color,
                  ),
                  onPressed: onTap,
                ),
                hasTitle
                    ? InkWell(
                        onTap: onTap,
                        child: Text(
                          title,
                          style: titleStyle ??
                              theme.textTheme.bodyText1.copyWith(
                                  color: AppColors.grey,
                                  fontSize: Sizes.TEXT_SIZE_14),
                        ),
                      )
                    : Container()
              ],
            ),
    );
  }
}
