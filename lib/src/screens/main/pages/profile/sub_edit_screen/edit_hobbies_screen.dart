part of '../edit_profile_screen.dart';

class EditHobbiesScreen extends StatefulWidget {
  @override
  _EditHobbiesScreenState createState() => _EditHobbiesScreenState();
}

class _EditHobbiesScreenState extends State<EditHobbiesScreen> {
  bool? isEdit;

  List<MultiSelectDialogItem<String>> dataSource =
      <MultiSelectDialogItem<String>>[
    MultiSelectDialogItem(
        label: 'Esports', value: 'Esports', icon: Icons.sports_esports),
    MultiSelectDialogItem(
        label: 'Musics', value: 'Music', icon: Icons.music_note),
    MultiSelectDialogItem(label: 'Movies', value: 'Movies', icon: Icons.tv),
    MultiSelectDialogItem(
        label: 'Football', value: 'Football', icon: Icons.sports_basketball),
  ];

  List? _myActivities;

  @override
  void initState() {
    super.initState();
    isEdit = false;

    _myActivities = [];
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Sở thích và mối quan tâm',
        actions: [SaveButton()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(sizeHelper.rW(3)),
        child: Column(
          children: <Widget>[
            MultiSelectHobby(
              autovalidate: false,
              chipBackGroundColor: _theme.primaryColor,
              chipLabelStyle: context.textTheme.bodyText1,
              dialogTextStyle: context.textTheme.bodyText1,
              checkBoxActiveColor: _theme.primaryColor,
              checkBoxCheckColor: _theme.colorScheme.onPrimary,
              dialogShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text(
                'Bạn làm gì để giải trí',
                style: TextStyle(fontSize: 16),
              ),
              validator: (value) {
                if (value == null || value.length == 0) {
                  // return 'Vui lòng chọn một hoặc nhiều tùy chọn';
                  return null;
                }
                return null;
              },
              dataSource: dataSource,
              okButtonLabel: 'lưu',
              cancelButtonLabel: 'hủy',
              hintWidget: Text('Vui lòng chọn một hoặc nhiều'),
              initialValue: _myActivities,
              onSaved: (value) {
                if (value == null) return;
                setState(() {
                  _myActivities = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
