part of '../edit_profile_screen.dart';

class EditReligionScreen extends StatefulWidget {
  @override
  _EditReligionScreenState createState() => _EditReligionScreenState();
}

class _EditReligionScreenState extends State<EditReligionScreen> {
  Religious selectedValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectedValue = Momentum.controller<CurrentUserController>(context)
          .model
          .currentUser
          ?.religious;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Quan điểm tôn giáo', actions: [
        SaveButton(onPressed: () {
          Momentum.controller<CurrentUserController>(context)
              .updateProfile(religious: selectedValue);
          Get.back();
        })
      ]),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioButtonGroup<Religious>(
                spacing: 1.0,
                items: Religious.getAll(),
                selectedItems: [selectedValue],
                valueToString: (v) => v.displayValue,
                onItemPressed: (value) => setState(() {
                  selectedValue = value;
                }),
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
