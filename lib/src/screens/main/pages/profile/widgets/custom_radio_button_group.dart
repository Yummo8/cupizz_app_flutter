part of '../edit_profile_screen.dart';

class RadioButtonGroup extends StatefulWidget {
  final List<String> buttonLables;
  final List<String> buttonValues;
  final ValueChanged<String> radioButtonValue;
  final double spacing;
  final defaultValue;

  const RadioButtonGroup(
      {Key key,
      this.buttonLables,
      this.buttonValues,
      this.radioButtonValue,
      this.spacing,
      this.defaultValue})
      : super(key: key);

  @override
  _RadioButtonGroupState createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState<T> extends State<RadioButtonGroup> {
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.buttonLables.length; i++) {
      bool isSelected = false;

      if (widget.defaultValue != null) {
        if (widget.defaultValue == widget.buttonValues[i]) isSelected = true;
      }

      sampleData.add(RadioModel(
          isSelected, widget.buttonLables[i], widget.buttonValues[i]));
    }
  }

  List<Widget> buildListItem() {
    return sampleData
        .mapIndexed(
          (item, index) => CustomItemChoice(
            item.lable,
            onChange: () {
              print(widget.radioButtonValue);
              widget.radioButtonValue(sampleData[index].value);

              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
              });
            },
            isSelected: sampleData[index].isSelected,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      children: buildListItem(),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String lable;
  final String value;

  RadioModel(this.isSelected, this.lable, this.value);
}
