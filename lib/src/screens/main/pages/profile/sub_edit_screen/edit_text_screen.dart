part of '../edit_profile_screen.dart';

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
    super.initState();
    _textController.text = widget.value != null ? widget.value : '';
    _textController.addListener(_textChange);
    isEdit = false;
    value = widget.value;
  }

  void _textChange() {
    if (_textController.text.isExistAndNotEmpty) {
      setState(() {
        isEdit = _textController.text != widget.value;
      });
    }
  }

  void _settingModalBottomSheet(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    SizeHelper sizeHelper = SizeHelper(context);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: _theme.colorScheme.onBackground.withOpacity(0.5),
        builder: (BuildContext bc) {
          return Container(
            decoration: new BoxDecoration(
                color: _theme.colorScheme.background,
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
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Divider(color: _theme.colorScheme.onSurface),
                  Text(
                      "Bạn có muốn lưu thay đổi vào hồ sơ hẹn hò của mình ko?"),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        minWidth: sizeHelper.rW(35),
                        color: context.colorScheme.onBackground,
                        child: Text(
                          "Bỏ",
                          style: context.textTheme.button
                              .copyWith(color: context.colorScheme.background),
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
                          style: context.textTheme.button
                              .copyWith(color: _theme.colorScheme.onPrimary),
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
    SizeHelper sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.background,
        title: Text(
          widget.title,
          style: context.textTheme.bodyText1,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.colorScheme.onBackground,
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
          TextButton(
            onPressed: !isEdit
                ? null
                : () {
                    widget.onSave(_textController.text);
                    setState(() {
                      isEdit = false;
                      value = _textController.text;
                    });
                  },
            child: Text(
              Strings.button.save,
              style: context.textTheme.button,
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
                style: context.textTheme.bodyText1,
              ),
              SizedBox(
                height: sizeHelper.rW(5),
              ),
              Text(
                "Hiển thị trên hồ sơ của bạn",
                style: context.textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
