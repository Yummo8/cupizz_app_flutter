part of '../edit_profile_screen.dart';

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(
      {@required this.value, @required this.label, @required this.icon});

  final V value;
  final String label;
  final IconData icon;
}

class MultiSelectDialogHobby<V> extends StatefulWidget {
  final List<MultiSelectDialogItem<V>> items;
  final List<V> initialSelectedValues;
  final Widget title;
  final String okButtonLabel;
  final String cancelButtonLabel;
  final TextStyle labelStyle;
  final ShapeBorder dialogShapeBorder;
  final Color checkBoxCheckColor;
  final Color checkBoxActiveColor;

  MultiSelectDialogHobby(
      {Key key,
      this.items,
      this.initialSelectedValues,
      this.title,
      this.okButtonLabel,
      this.cancelButtonLabel,
      this.labelStyle = const TextStyle(),
      this.dialogShapeBorder,
      this.checkBoxActiveColor,
      this.checkBoxCheckColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogHobbyState<V>();
}

class _MultiSelectDialogHobbyState<V> extends State<MultiSelectDialogHobby<V>> {
  final _selectedValues = <V>[];

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      shape: widget.dialogShapeBorder,
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _onCancelTap,
          child: Text(widget.cancelButtonLabel),
        ),
        TextButton(
          onPressed: _onSubmitTap,
          child: Text(widget.okButtonLabel),
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      checkColor: widget.checkBoxCheckColor,
      activeColor: widget.checkBoxActiveColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            item.icon,
            color: context.colorScheme.onBackground,
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            item.label,
            style: widget.labelStyle,
          )
        ],
      ),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}
