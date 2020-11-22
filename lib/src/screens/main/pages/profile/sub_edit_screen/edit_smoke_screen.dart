import 'package:cupizz_app/src/helpers/index.dart';
import 'package:cupizz_app/src/screens/main/pages/profile/widgets/custom_radio_button_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditSmokeScreen extends StatefulWidget {
  @override
  _EditSmokeScreenState createState() => _EditSmokeScreenState();
}

class _EditSmokeScreenState extends State<EditSmokeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);
    final ThemeData _theme = Theme.of(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Hút thuốc',
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
                  'Không bao giờ',
                  'Thỉnh thoảng',
                  'Thường xuyên',
                  'Không muốn tiết lộ'
                ],
                buttonValues: [
                  'Không bao giờ',
                  'Thỉnh thoảng',
                  'Thường xuyên',
                  'Không muốn tiết lộ'
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
