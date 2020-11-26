part of '../edit_profile_screen.dart';

class EditDrinkScreen extends StatefulWidget {
  @override
  _EditDrinkScreenState createState() => _EditDrinkScreenState();
}

class _EditDrinkScreenState extends State<EditDrinkScreen> {
  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Rượu bia',
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
