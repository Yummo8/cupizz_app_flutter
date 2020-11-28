part of '../edit_profile_screen.dart';

class CustomItemChoice extends StatefulWidget {
  const CustomItemChoice(this.label,
      {Key key,
      @required this.onChange,
      this.selectedBackgroundColor,
      this.notSelectedBackgroundColor,
      this.selectedTextColor,
      this.notSelectedTextColor,
      this.isSelected = false})
      : super(key: key);

  final String label;
  final Function onChange;
  final Color selectedBackgroundColor;
  final Color selectedTextColor;
  final Color notSelectedBackgroundColor;
  final Color notSelectedTextColor;
  final bool isSelected;

  @override
  _CustomItemChoiceState createState() => _CustomItemChoiceState();
}

class _CustomItemChoiceState extends State<CustomItemChoice> {
  @override
  void initState() {
    super.initState();
  }

  void _onTap() {
    widget.onChange();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    var backgroundColor = widget.isSelected
        ? (widget.selectedBackgroundColor ??
            _theme.primaryColor.withOpacity(0.1))
        : (widget.notSelectedBackgroundColor ??
            context.colorScheme.onBackground);
    var textColor = widget.isSelected
        ? (widget.selectedTextColor ?? _theme.primaryColor)
        : (widget.notSelectedTextColor ?? context.colorScheme.background);
    return FlatButton(
      onPressed: () {
        _onTap();
      },
      shape: StadiumBorder(),
      color: backgroundColor,
      child: Text(
        widget.label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15, color: textColor),
      ),
    );
  }
}
