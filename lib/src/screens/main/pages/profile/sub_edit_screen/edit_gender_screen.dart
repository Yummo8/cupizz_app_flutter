part of '../edit_profile_screen.dart';

class EditGenderScreen extends StatefulWidget {
  @override
  _EditGenderScreenState createState() => _EditGenderScreenState();
}

class _EditGenderScreenState extends State<EditGenderScreen> {
  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);

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
                  'Nam',
                  'Nữ',
                ],
                buttonValues: [
                  'Nam',
                  'Nữ',
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
