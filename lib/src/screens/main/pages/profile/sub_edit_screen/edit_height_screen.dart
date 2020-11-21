import 'package:cupizz_app/src/helpers/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditHeightScreen extends StatefulWidget {
  @override
  _EditHeightScreenState createState() => _EditHeightScreenState();
}

class _EditHeightScreenState extends State<EditHeightScreen> {
  final elements = [for (var i = 140; i < 200; i += 1) '$i cm'];
  int selectedIndex = 0;
  String selected;

  List<Widget> _buildItems() {
    return elements
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chiều cao',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton(
                isExpanded: true,
                hint: new Text("Chọn chiều cao"),
                value: selected,
                onChanged: (String newValue) {
                  setState(() {
                    selected = newValue;
                  });
                },
                items: elements.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              // DirectSelect(
              //   itemExtent: 35.0,
              //   selectedIndex: selectedIndex,
              //   child: MySelectionItem(
              //     isForList: false,
              //     title: elements[selectedIndex],
              //   ),
              //   onSelectedItemChanged: (index) {
              //     setState(() {
              //       selectedIndex = index;
              //     });
              //   },
              //   items: _buildItems(),
              // ),
              SizedBox(
                height: sizeHelper.rW(5),
              ),
              Text(
                "Hiển thị trên hồ sơ của bạn",
                style: TextStyle(color: Colors.black54, fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}
