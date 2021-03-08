part of '../edit_profile_screen.dart';

class RadioButtonGroup<T> extends StatelessWidget {
  final List<T>? items;
  final ValueChanged<T>? onItemPressed;
  final String Function(T)? valueToString;
  final double spacing;
  final List<T>? selectedItems;

  const RadioButtonGroup({
    Key? key,
    this.items,
    this.onItemPressed,
    this.spacing = 10,
    this.selectedItems,
    this.valueToString,
  }) : super(key: key);

  List<Widget> buildListItem() {
    return (items ?? [])
        .mapIndexed(
          ((item, index) => CustomItemChoice(
                valueToString!(item),
                onChange: () {
                  onItemPressed!(item);
                },
                isSelected: selectedItems!.contains(item),
              )),
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
