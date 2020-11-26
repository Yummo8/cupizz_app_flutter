part of '../edit_profile_screen.dart';

class EditLookupScreen extends StatefulWidget {
  @override
  _EditLookupScreenState createState() => _EditLookupScreenState();
}

class _EditLookupScreenState extends State<EditLookupScreen> {
  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Đang tìm kiếm',
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
              Text(
                "Bạn mong muốn điều gì? Hãy chọn tất cả đáp án phù hợp.",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: sizeHelper.rW(5),
              ),
              CheckBoxGroup(
                spacing: 1.0,
                buttonLables: [
                  'Người trò chuyện',
                  'Quan hệ bạn bè',
                  'Hẹn hò thoải mái',
                  'Mối quan hệ lâu dài',
                  'Không muốn tiết lộ',
                ],
                buttonValues: [
                  'Người trò chuyện',
                  'Quan hệ bạn bè',
                  'Hẹn hò thoải mái',
                  'Mối quan hệ lâu dài',
                  'Không muốn tiết lộ',
                ],
                checkBoxButtonValues: (values) {
                  print(values);
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
