part of '../edit_profile_screen.dart';

class RadioButtonGroup<T> extends StatelessWidget {
  final List<T> items;
  final ValueChanged<T> radioButtonValue;
  final String Function(T) valueToString;
  final double spacing;
  final T value;

  const RadioButtonGroup({
    Key key,
    this.items,
    this.radioButtonValue,
    this.spacing = 10,
    this.value,
    this.valueToString,
  }) : super(key: key);

  List<Widget> buildListItem() {
    return items
        .mapIndexed(
          (item, index) => CustomItemChoice(
            valueToString(item),
            onChange: () {
              radioButtonValue(item);
            },
            isSelected: value == item,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      children: buildListItem(),
    );
  }
}
