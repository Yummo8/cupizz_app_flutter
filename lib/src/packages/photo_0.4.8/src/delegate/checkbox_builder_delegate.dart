import 'package:flutter/material.dart' hide CheckboxListTile;
import '../entity/options.dart';
import '../provider/i18n_provider.dart';
import '../ui/widget/check_tile_copy.dart';

abstract class CheckBoxBuilderDelegate {
  Widget buildCheckBox(
    BuildContext context,
    bool checked,
    int index,
    Options options,
    I18nProvider i18nProvider,
  );
}

class DefaultCheckBoxBuilderDelegate extends CheckBoxBuilderDelegate {
  DefaultCheckBoxBuilderDelegate({
    this.activeColor = Colors.white,
    this.unselectedColor = Colors.white,
    this.checkColor = Colors.black,
  });

  final Color activeColor;
  final Color unselectedColor;

  final Color checkColor;

  @override
  Widget buildCheckBox(
    BuildContext context,
    bool checked,
    int index,
    Options options,
    I18nProvider i18nProvider,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: unselectedColor),
      child: CheckboxListTile(
        value: checked,
        onChanged: (bool check) {},
        activeColor: activeColor,
        checkColor: checkColor,
        title: Text(
          i18nProvider.getSelectedOptionsText(options),
          textAlign: TextAlign.end,
          style: TextStyle(color: options.textColor),
        ),
      ),
    );
  }
}

class RadioCheckBoxBuilderDelegate extends CheckBoxBuilderDelegate {
  RadioCheckBoxBuilderDelegate({
    this.activeColor = Colors.white,
    this.unselectedColor = Colors.white,
  });

  final Color activeColor;
  final Color unselectedColor;

  @override
  Widget buildCheckBox(
    BuildContext context,
    bool checked,
    int index,
    Options options,
    I18nProvider i18nProvider,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: unselectedColor),
      child: RadioListTile<bool>(
        value: true,
        onChanged: (bool check) {},
        activeColor: activeColor,
        title: Text(
          i18nProvider.getSelectedOptionsText(options),
          textAlign: TextAlign.end,
          style: TextStyle(color: options.textColor, fontSize: 14.0),
        ),
        groupValue: checked,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
