import 'package:cupizz_app/src/helpers/index.dart';
import 'package:cupizz_app/src/screens/main/pages/profile/widgets/multi_select_hobby.dart';
import 'package:cupizz_app/src/screens/main/pages/profile/widgets/multiselect_dialog_hobby.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditHobbiesScreen extends StatefulWidget {
  @override
  _EditHobbiesScreenState createState() => _EditHobbiesScreenState();
}

class _EditHobbiesScreenState extends State<EditHobbiesScreen> {
  bool isEdit;
  List<MultiSelectDialogItem<String>> _selectedItems =
      List<MultiSelectDialogItem<String>>();

  List<MultiSelectDialogItem<String>> dataSource =
      <MultiSelectDialogItem<String>>[
    MultiSelectDialogItem(
        label: "Esports", value: "Esports", icon: Icons.sports_esports),
    MultiSelectDialogItem(
        label: "Musics", value: "Music", icon: Icons.music_note),
    MultiSelectDialogItem(label: "Movies", value: "Movies", icon: Icons.tv),
    MultiSelectDialogItem(
        label: "Football", value: "Football", icon: Icons.sports_basketball),
  ];

  List _myActivities;
  String _myActivitiesResult;

  @override
  void initState() {
    super.initState();
    isEdit = false;

    _myActivities = [];
    _myActivitiesResult = '';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    SizeHelper sizeHelper = SizeHelper(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Sở thích và mối quan tâm',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
        actions: [
          InkWell(
            onTap: isEdit ? () {} : null,
            child: Center(
              child: Text(
                "Lưu",
                style: TextStyle(
                    color: isEdit ? _theme.primaryColor : Colors.black54,
                    fontSize: 18.0),
              ),
            ),
          ),
          SizedBox(
            width: sizeHelper.rW(8),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(sizeHelper.rW(3)),
        child: Column(
          children: <Widget>[
            MultiSelectHobby(
              autovalidate: false,
              chipBackGroundColor: _theme.primaryColor,
              chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
              checkBoxActiveColor: _theme.primaryColor,
              checkBoxCheckColor: Colors.white,
              dialogShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text(
                "Bạn làm gì để giải trí",
                style: TextStyle(fontSize: 16),
              ),
              validator: (value) {
                if (value == null || value.length == 0) {
                  // return 'Vui lòng chọn một hoặc nhiều tùy chọn';
                  return null;
                }
                return null;
              },
              dataSource: dataSource,
              okButtonLabel: 'lưu',
              cancelButtonLabel: 'hủy',
              hintWidget: Text('Vui lòng chọn một hoặc nhiều'),
              initialValue: _myActivities,
              onSaved: (value) {
                if (value == null) return;
                setState(() {
                  _myActivities = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
