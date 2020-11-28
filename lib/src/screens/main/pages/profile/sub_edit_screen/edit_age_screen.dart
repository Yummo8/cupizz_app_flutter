part of '../edit_profile_screen.dart';

class EditAgeScreen extends StatefulWidget {
  @override
  _EditAgeScreenState createState() => _EditAgeScreenState();
}

class _EditAgeScreenState extends State<EditAgeScreen> {
  DateTime selectedDate = DateTime(1998, 04, 25);

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now().subtract(new Duration(days: 365 * 50)),
      lastDate: DateTime.now().subtract(new Duration(days: 365 * 18)),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(title: Strings.common.birthday),
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
