import 'package:flutter/material.dart';

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
    final ThemeData _theme = Theme.of(context);
    return InkWell(
      onTap: () => {
        if (onClick != null) {onClick()}
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            this.iconData,
            color: _theme.primaryColor,
            size: 18.0,
            semanticLabel: this.semanticLabel,
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Text(
              this.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
