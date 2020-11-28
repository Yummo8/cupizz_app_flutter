part of '../edit_profile_screen.dart';

class EditLookupScreen extends StatefulWidget {
  @override
  _EditLookupScreenState createState() => _EditLookupScreenState();
}

class _EditLookupScreenState extends State<EditLookupScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeHelper = SizeHelper(context);
    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Đang tìm kiếm'),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bạn mong muốn điều gì? Hãy chọn tất cả đáp án phù hợp.',
                style: context.textTheme.bodyText1,
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
              ShowOnProfileText(),
            ],
          ),
        ),
      ),
    );
  }
}
