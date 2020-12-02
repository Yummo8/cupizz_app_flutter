part of '../edit_profile_screen.dart';

class EditAgeScreen extends StatefulWidget {
  @override
  _EditAgeScreenState createState() => _EditAgeScreenState();
}

class _EditAgeScreenState extends State<EditAgeScreen> {
  DateTime selectedDate = DateTime(1998, 04, 25);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedDate = Momentum.controller<CurrentUserController>(context)
            .model
            .currentUser
            .birthday;
      });
    });
  }

  void _selectDate(BuildContext context) async {
    final firstDate = DateTime.now().subtract(Duration(days: 365 * 80));
    final lastDate = DateTime.now().subtract(Duration(days: 365 * 18));
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, 
      firstDate: selectedDate.isBefore(firstDate) ? selectedDate : firstDate,
      lastDate: selectedDate.isAfter(lastDate) ? selectedDate : lastDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(
        title: Strings.common.birthday,
        actions: [
          SaveButton(onPressed: () {
            Momentum.controller<CurrentUserController>(context)
                .updateProfile(birthday: selectedDate);
          })
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Center(
                  child: Text(
                    formateDatetime(selectedDate),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
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
