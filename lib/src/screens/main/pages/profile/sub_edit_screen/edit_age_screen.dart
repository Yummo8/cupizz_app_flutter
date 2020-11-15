import 'package:cupizz_app/src/helpers/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditAgeScreen extends StatefulWidget {
  @override
  _EditAgeScreenState createState() => _EditAgeScreenState();
}

class _EditAgeScreenState extends State<EditAgeScreen> {
  DateTime selectedDate = DateTime(1998, 04, 25);

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now().subtract(new Duration(days: 365 * 50)),
      lastDate: DateTime.now().subtract(new Duration(days: 365 * 18)),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Ngày sinh',
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
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Center(
                  child: Text(
                    formateDatetime(selectedDate),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
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
