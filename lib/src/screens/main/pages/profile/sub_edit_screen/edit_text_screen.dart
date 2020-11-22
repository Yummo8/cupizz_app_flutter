import 'package:cupizz_app/src/helpers/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditTextScreen extends StatefulWidget {
  final ValueChanged<String> onSave;
  final String title;
  final String value;

  const EditTextScreen(
      {Key key, @required this.title, @required this.onSave, this.value})
      : super(key: key);

  @override
  _EditTextScreenState createState() => _EditTextScreenState();
}

class _EditTextScreenState extends State<EditTextScreen> {
  final TextEditingController _textController = TextEditingController();
  bool isEdit;
  String value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController.text = widget.value != null ? widget.value : '';
    _textController.addListener(_textChange);
    isEdit = false;
    value = widget.value;
  }

  void _textChange() {
    print(_textController.text);
    if (widget.value != null) {
      if (_textController.text == widget.value) {
        setState(() {
          isEdit = true;
        });
      }
    } else {
      if (_textController.text.length > 0) {
        setState(() {
          isEdit = true;
        });
      }
    }
  }

  void _settingModalBottomSheet(context) {
    ThemeData _theme = Theme.of(context);
    SizeHelper sizeHelper = SizeHelper(context);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(15.0),
                    topRight: const Radius.circular(15.0))),
            height: sizeHelper.rH(25),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: null,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Text(
                      "Bạn có muốn lưu thay đổi vào hồ sơ hẹn hò của mình ko?"),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        minWidth: sizeHelper.rW(35),
                        color: Colors.grey[200],
                        child: Text(
                          "Bỏ",
                          style: TextStyle(color: Colors.black),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      ),
                      FlatButton(
                        onPressed: () {
                          widget.onSave(_textController.text);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        minWidth: sizeHelper.rW(35),
                        color: _theme.primaryColor,
                        child: Text(
                          "Lưu",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    SizeHelper sizeHelper = SizeHelper(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            if (isEdit) {
              _settingModalBottomSheet(context);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              if (isEdit) {
                widget.onSave(_textController.text);
                setState(() {
                  isEdit = false;
                  value = _textController.text;
                });
              }
            },
            child: Center(
              child: Text(
                "Lưu",
                style: TextStyle(
                    color: isEdit ? _theme.primaryColor : Colors.black87,
                    fontSize: 18.0),
              ),
            ),
          ),
          SizedBox(
            width: sizeHelper.rW(8),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _textController,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
