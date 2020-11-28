part of '../edit_profile_screen.dart';

class EditDrinkScreen extends StatefulWidget {
  @override
  _EditDrinkScreenState createState() => _EditDrinkScreenState();
}

class _EditDrinkScreenState extends State<EditDrinkScreen> {
  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Rượu bia'),
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
              SizedBox(height: sizeHelper.rW(5)),
              ShowOnProfileText(),
            ],
          ),
        ),
      ),
    );
  }
}
