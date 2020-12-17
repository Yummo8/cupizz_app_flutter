part of '../edit_profile_screen.dart';

class MultiSelectHobby extends FormField<dynamic> {
  final Widget title;
  final Widget hintWidget;
  final bool required;
  final String errorText;
  final List<MultiSelectDialogItem> dataSource;
  final Function change;
  final Function open;
  final Function close;
  final Widget leading;
  final Widget trailing;
  final String okButtonLabel;
  final String cancelButtonLabel;
  final Color fillColor;
  final InputBorder border;
  final TextStyle chipLabelStyle;
  final Color chipBackGroundColor;
  final TextStyle dialogTextStyle;
  final ShapeBorder dialogShapeBorder;
  final Color checkBoxCheckColor;
  final Color checkBoxActiveColor;
  @override
  final bool enabled;

  MultiSelectHobby({
    FormFieldSetter<dynamic> onSaved,
    FormFieldValidator<dynamic> validator,
    dynamic initialValue,
    bool autovalidate = false,
    this.title = const Text('Title'),
    this.hintWidget = const Text('Tap to select one or more'),
    this.required = false,
    this.errorText = 'Please select one or more options',
    this.leading,
    this.dataSource,
    this.change,
    this.open,
    this.close,
    this.okButtonLabel = 'OK',
    this.cancelButtonLabel = 'CANCEL',
    this.fillColor,
    this.border,
    this.trailing,
    this.chipLabelStyle,
    this.enabled = true,
    this.chipBackGroundColor,
    this.dialogTextStyle = const TextStyle(),
    this.dialogShapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    ),
    this.checkBoxActiveColor,
    this.checkBoxCheckColor,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          // ignore: deprecated_member_use
          autovalidate: autovalidate,
          builder: (FormFieldState<dynamic> state) {
            List<Widget> _buildSelectedOptions(FormFieldState<dynamic> state) {
              var selectedOptions = <Widget>[];

              if (state.value != null) {
                state.value.forEach((item) {
                  var existingItem = dataSource.singleWhere(
                      (itm) => itm.value == item,
                      orElse: () => null);
                  selectedOptions.add(Chip(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    labelStyle: chipLabelStyle,
                    backgroundColor: chipBackGroundColor,
                    avatar: Icon(existingItem.icon,
                        color: state.context.colorScheme.onPrimary),
                    label: Text(
                      existingItem.label,
                      style:
                          TextStyle(color: state.context.colorScheme.onPrimary),
                    ),
                  ));
                });
              }

              return selectedOptions;
            }

            return InkWell(
              onTap: !enabled
                  ? null
                  : () async {
                      List initialSelected = state.value;
                      initialSelected ??= [];

                      var selectedValues = await showDialog<List>(
                        context: state.context,
                        builder: (BuildContext context) {
                          return MultiSelectDialogHobby(
                            title: title,
                            okButtonLabel: okButtonLabel,
                            cancelButtonLabel: cancelButtonLabel,
                            items: dataSource,
                            initialSelectedValues: initialSelected,
                            labelStyle: dialogTextStyle,
                            dialogShapeBorder: dialogShapeBorder,
                            checkBoxActiveColor: checkBoxActiveColor,
                            checkBoxCheckColor: checkBoxCheckColor,
                          );
                        },
                      );

                      if (selectedValues != null) {
                        state.didChange(selectedValues);
                        state.save();
                      }
                    },
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  errorText: state.hasError ? state.errorText : null,
                  errorMaxLines: 4,
                  fillColor: fillColor ?? Theme.of(state.context).canvasColor,
                  border: border ?? UnderlineInputBorder(),
                ),
                isEmpty: state.value == null || state.value == '',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: title,
                          ),
                          required
                              ? Padding(
                                  padding: EdgeInsets.only(top: 5, right: 5),
                                  child: Text(
                                    ' *',
                                    style: state.context.textTheme.bodyText1,
                                  ),
                                )
                              : Container(),
                          Icon(
                            Icons.arrow_drop_down,
                            color: state.context.colorScheme.onBackground,
                            size: 25.0,
                          ),
                        ],
                      ),
                    ),
                    state.value != null && state.value.length > 0
                        ? Wrap(
                            spacing: 8.0,
                            runSpacing: 0.0,
                            children: _buildSelectedOptions(state),
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 4),
                            child: hintWidget,
                          )
                  ],
                ),
              ),
            );
          },
        );
}
