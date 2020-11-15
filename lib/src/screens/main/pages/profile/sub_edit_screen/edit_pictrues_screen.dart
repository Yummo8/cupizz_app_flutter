import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPicturesScreen extends StatefulWidget {
  @override
  _EditPicturesScreenState createState() => _EditPicturesScreenState();
}

class _EditPicturesScreenState extends State<EditPicturesScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeHelper sizeHelper = SizeHelper(context);
    final ThemeData _theme = Theme.of(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Vị trí hẹn hò',
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
            onTap: () {},
            child: Center(
              child: Text(
                "Lưu",
                style: TextStyle(color: _theme.primaryColor, fontSize: 15.0),
              ),
            ),
          ),
          SizedBox(
            width: sizeHelper.rW(8),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            children: [
              Container(
                height: sizeHelper.rH(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.near_me,
                      color: _theme.primaryColor,
                    ),
                    Text(
                      "Cập nhật vị trí hẹn hò",
                      style: TextStyle(
                          color: _theme.primaryColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {},
                color: _theme.primaryColor.withOpacity(0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.near_me,
                      color: _theme.primaryColor,
                    ),
                    Text(
                      "Cập nhật vị trí hẹn hò",
                      style: TextStyle(
                          color: _theme.primaryColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
