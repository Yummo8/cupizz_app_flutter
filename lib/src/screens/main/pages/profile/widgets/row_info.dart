part of '../profile_screen.dart';

class RowInfo extends StatelessWidget {
  final String semanticLabel;
  final IconData iconData;
  final String title;
  final Function onClick;

  RowInfo({
    Key key,
    this.semanticLabel,
    this.iconData,
    this.title,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            this.iconData,
            color: context.colorScheme.primary,
            size: 18.0,
            semanticLabel: this.semanticLabel,
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Text(
              this.title,
              style: context.textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}
