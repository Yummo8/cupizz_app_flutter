part of '../edit_profile_screen.dart';

class EditLookupScreen extends StatefulWidget {
  @override
  _EditLookupScreenState createState() => _EditLookupScreenState();
}

class _EditLookupScreenState extends State<EditLookupScreen> {
  List<LookingFor>? selectedValues = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      selectedValues = Momentum.controller<CurrentUserController>(context)
          .model!
          .currentUser
          ?.lookingFors;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeHelper = SizeHelper(context);
    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Đang tìm kiếm', actions: [
        SaveButton(onPressed: () {
          Momentum.controller<CurrentUserController>(context)
              .updateProfile(lookingFors: selectedValues);
          Get.back();
        })
      ]),
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
              RadioButtonGroup<LookingFor>(
                spacing: 1.0,
                items: LookingFor.getAll(),
                selectedItems: selectedValues,
                valueToString: (v) => v.displayValue,
                onItemPressed: (value) => setState(() {
                  if (selectedValues!.contains(value)) {
                    selectedValues!.remove(value);
                  } else {
                    selectedValues!.add(value);
                  }
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
