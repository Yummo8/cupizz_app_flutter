part of '../edit_profile_screen.dart';

class EditMarriageScreen extends StatefulWidget {
  @override
  _EditMarriageScreenState createState() => _EditMarriageScreenState();
}

class _EditMarriageScreenState extends State<EditMarriageScreen> {
  HaveKids? selectedValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      selectedValue = Momentum.controller<CurrentUserController>(context)
          .model!
          .currentUser
          ?.yourKids;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Có con', actions: [
        SaveButton(onPressed: () {
          Momentum.controller<CurrentUserController>(context)
              .updateProfile(yourKids: selectedValue);
          Get.back();
        })
      ]),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioButtonGroup<HaveKids?>(
                spacing: 1.0,
                items: HaveKids.getAll(),
                selectedItems: [selectedValue],
                valueToString: (v) => v!.displayValue,
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
