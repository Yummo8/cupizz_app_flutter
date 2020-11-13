import 'package:cupizz_app/src/helpers/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditCompanyScreen extends StatefulWidget {
  @override
  _EditCompanyScreenState createState() => _EditCompanyScreenState();
}

class _EditCompanyScreenState extends State<EditCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Bạn đang làm việc ở đâu',
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
              TextField(),
              SizedBox(
                height: sizeHelper.rW(5),
              ),
              Text(
                "Hiển thị trên hồ sơ của bạn",
                style: TextStyle(color: Colors.black54, fontSize: 15.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
