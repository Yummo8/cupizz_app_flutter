import 'package:cupizz_app/src/helpers/index.dart';
import 'package:cupizz_app/src/screens/main/pages/profile/widgets/custom_radio_button_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditReligionScreen extends StatefulWidget {
  @override
  _EditReligionScreenState createState() => _EditReligionScreenState();
}

class _EditReligionScreenState extends State<EditReligionScreen> {
  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);
    final ThemeData _theme = Theme.of(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Quan điểm tôn giáo',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioButtonGroup(
                spacing: 1.0,
                buttonLables: [
                  'Không muốn tiết lộ',
                  'Công giáo',
                  'Do thái',
                  'Hindu giáo',
                  'Khác'
                ],
                buttonValues: [
                  'Không muốn tiết lộ',
                  'Công giáo',
                  'Do thái',
                  'Hindu giáo',
                  'Khác'
                ],
                radioButtonValue: (value) => print(value),
              ),
              SizedBox(
                height: sizeHelper.rW(5),
              ),
              Text(
                "Hiển thị trên hồ sơ của bạn",
                style: TextStyle(color: Colors.black54, fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
