part of '../edit_profile_screen.dart';

class EditEducationLevelScreen extends StatefulWidget {
  @override
  _EditEducationLevelScreenState createState() =>
      _EditEducationLevelScreenState();
}

class _EditEducationLevelScreenState extends State<EditEducationLevelScreen> {
  EducationLevel selectedValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectedValue = Momentum.controller<CurrentUserController>(context)
          .model
          .currentUser
          ?.educationLevel;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(title: Strings.common.educationLevel, actions: [
        SaveButton(onPressed: () {
          Momentum.controller<CurrentUserController>(context)
              .updateProfile(educationLevel: selectedValue);
          Router.pop(context);
        })
      ]),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioButtonGroup<EducationLevel>(
                spacing: 1.0,
                items: EducationLevel.getAll(),
                selectedItems: [selectedValue],
                valueToString: (v) => v.displayValue,
                onItemPressed: (value) => setState(() {
                  selectedValue = value;
                }),
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
