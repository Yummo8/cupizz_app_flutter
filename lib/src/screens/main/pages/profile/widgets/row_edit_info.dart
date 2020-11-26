part of '../edit_profile_screen.dart';

class RowEditInfo extends StatelessWidget {
  final String semanticLabel;
  final IconData iconData;
  final String title;
  final String value;
  final Function onClick;

  RowEditInfo(
      {Key key,
      this.semanticLabel = "",
      this.iconData,
      this.title,
      this.value,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);
    return InkWell(
      onTap: onClick,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            this.iconData,
            color: context.colorScheme.onBackground,
            size: sizeHelper.rW(10.0),
            semanticLabel: this.semanticLabel,
          ),
          SizedBox(width: sizeHelper.rW(3.0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.title,
                style: context.textTheme.bodyText1,
              ),
              SizedBox(height: sizeHelper.rH(1)),
              Text(
                this.value,
                style: context.textTheme.bodyText2,
              ),
            ],
          )
        ],
      ),
    );
  }
}
