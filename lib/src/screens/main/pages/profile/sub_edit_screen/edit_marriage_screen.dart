import 'package:cupizz_app/src/helpers/index.dart';
import 'package:cupizz_app/src/screens/main/pages/profile/widgets/custom_radio_button_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditMarriageScreen extends StatefulWidget {
  @override
  _EditMarriageScreenState createState() => _EditMarriageScreenState();
}

class _EditMarriageScreenState extends State<EditMarriageScreen> {
  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Có con',
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
                  'Tôi chưa có con',
                  'Tôi đã có con',
                  'Không muốn tiết lộ',
                ],
                buttonValues: [
                  'Tôi chưa có con',
                  'Tôi đã có con',
                  'Không muốn tiết lộ',
                ],
                radioButtonValue: (value) {
                  print(value);
                },
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
