part of '../user_profile.dart';

class RowInfo extends StatelessWidget {
  final String? semanticLabel;
  final IconData? iconData;
  final String? title;
  final Function? onClick;

  RowInfo({
    Key? key,
    this.semanticLabel,
    this.iconData,
    this.title,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: InkWell(
        onTap: onClick as void Function()?,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              iconData,
              color: context.colorScheme.primary,
              size: 18.0,
              semanticLabel: semanticLabel,
            ),
            const SizedBox(width: 20.0),
            Flexible(
              child: Text(
                title ?? '',
                style: context.textTheme.bodyText1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
