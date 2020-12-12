part of dash_chat;

class DateBuilder extends StatelessWidget {
  DateBuilder({
    Key key,
    @required this.date,
    this.customDateBuilder,
    this.dateFormat,
  }) : super(key: key);

  final DateTime date;
  final Widget Function(String) customDateBuilder;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    if (customDateBuilder != null) {
      return customDateBuilder(
        dateFormat != null
            ? dateFormat.format(date)
            : DateFormat('yyyy-MM-dd').format(date),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.only(
          bottom: 5.0,
          top: 5.0,
          left: 10.0,
          right: 10.0,
        ),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          dateFormat != null
              ? dateFormat.format(date.toLocal())
              : DateFormat('yyyy-MMM-dd').format(date.toLocal()),
          style: TextStyle(
            color: context.colorScheme.onSurface,
            fontSize: 12.0,
          ),
        ),
      );
    }
  }
}
