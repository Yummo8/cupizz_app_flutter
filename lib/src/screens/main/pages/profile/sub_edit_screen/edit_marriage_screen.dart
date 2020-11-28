part of '../edit_profile_screen.dart';

class EditMarriageScreen extends StatefulWidget {
  @override
  _EditMarriageScreenState createState() => _EditMarriageScreenState();
}

class _EditMarriageScreenState extends State<EditMarriageScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Có con'),
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
              ShowOnProfileText(),
            ],
          ),
        ),
      ),
    );
  }
}
