part of '../edit_profile_screen.dart';

class EditReligionScreen extends StatefulWidget {
  @override
  _EditReligionScreenState createState() => _EditReligionScreenState();
}

class _EditReligionScreenState extends State<EditReligionScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Quan điểm tôn giáo'),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioButtonGroup(
                spacing: 1.0,
                buttonLables: [
                  'Không muốn tiết lộ',
                  'Công giáo',
                  'Do thái',
                  'Hindu giáo',
                  'Khác'
                ],
                buttonValues: [
                  'Không muốn tiết lộ',
                  'Công giáo',
                  'Do thái',
                  'Hindu giáo',
                  'Khác'
                ],
                radioButtonValue: (value) => print(value),
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
