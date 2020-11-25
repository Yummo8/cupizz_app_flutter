import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter/material.dart';

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
      onTap: () => {
        if (onClick != null) {onClick()}
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            this.iconData,
            color: Colors.black87,
            size: sizeHelper.rW(10.0),
            semanticLabel: this.semanticLabel,
          ),
          SizedBox(
            width: sizeHelper.rW(3.0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: sizeHelper.rW(5),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: sizeHelper.rH(1),
              ),
              Text(
                this.value,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: sizeHelper.rW(4.8),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
