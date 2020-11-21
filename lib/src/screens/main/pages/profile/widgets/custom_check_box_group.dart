import 'package:cupizz_app/src/helpers/extensions.dart';
import 'package:flutter/cupertino.dart';

import 'custom_item_choice.dart';

class CheckBoxGroup extends StatefulWidget {
  final List<String> buttonLables;
  final List<String> buttonValues;
  final ValueChanged<List<String>> checkBoxButtonValues;
  final double spacing;
  final List defaultValues;

  const CheckBoxGroup(
      {Key key,
      this.buttonLables,
      this.buttonValues,
      this.checkBoxButtonValues,
      this.spacing,
      this.defaultValues})
      : super(key: key);

  @override
  _CheckBoxGroupState createState() => _CheckBoxGroupState();
}

class _CheckBoxGroupState extends State<CheckBoxGroup> {
  List<CheckBoxModel> sampleData = new List<CheckBoxModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < widget.buttonLables.length; i++) {
      bool isSelected = false;

      if (widget.defaultValues != null && widget.defaultValues.length > 0) {
        if (_checkDefaultValue(widget.buttonValues[i])) isSelected = true;
      }

      sampleData.add(CheckBoxModel(
          isSelected, widget.buttonLables[i], widget.buttonValues[i]));
    }
  }

  bool _checkDefaultValue(value) {
    for (var i = 0; i < widget.defaultValues.length; i++) {
      if (widget.defaultValues[i] == value) return true;
    }
    return false;
  }

  List<Widget> buildListItem() {
    return sampleData
        .mapIndexed(
          (item, index) => CustomItemChoice(
            item.lable,
            onChange: () {
              setState(() {
                sampleData[index].isSelected = !sampleData[index].isSelected;
                widget.checkBoxButtonValues(sampleData
                    .where((element) => element.isSelected)
                    .toList()
                    .map((e) => e.value)
                    .toList());
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

class CheckBoxModel {
  bool isSelected;
  final String lable;
  final String value;

  CheckBoxModel(this.isSelected, this.lable, this.value);
}
