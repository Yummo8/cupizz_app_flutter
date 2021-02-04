part of '../edit_profile_screen.dart';

class EditTextScreenParams extends RouterParam {
  final ValueChanged<String> onSave;
  final String title;
  final String value;

  EditTextScreenParams({this.onSave, this.title, this.value});
}

class EditTextScreen extends StatefulWidget {
  @override
  _EditTextScreenState createState() => _EditTextScreenState();
}

class _EditTextScreenState extends State<EditTextScreen> {
  final TextEditingController _textController = TextEditingController();
  bool isEdit = false;
  String value;
  EditTextScreenParams params;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      params = Router.getParam<EditTextScreenParams>(context);
      _textController.text = params?.value != null ? params.value : '';
      _textController.addListener(_textChange);
      isEdit = false;
      value = params?.value;
      setState(() {});
    });
  }

  void _textChange() {
    if (_textController.text.isExistAndNotEmpty) {
      setState(() {
        isEdit = _textController.text != params?.value;
      });
    }
  }

  void _settingModalBottomSheet(BuildContext context) {
    var _theme = Theme.of(context);
    final sizeHelper = SizeHelper(context);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: _theme.colorScheme.onBackground.withOpacity(0.5),
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                color: _theme.colorScheme.background,
                borderRadius: BorderRadius.only(
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
                      'Bạn có muốn lưu thay đổi vào hồ sơ hẹn hò của mình ko?'),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: context.colorScheme.onBackground,
                          minimumSize: Size.fromWidth(sizeHelper.rW(35)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                        child: Text(
                          'Bỏ',
                          style: context.textTheme.button
                              .copyWith(color: context.colorScheme.background),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          params?.onSave(_textController.text);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: _theme.primaryColor,
                          minimumSize: Size.fromWidth(sizeHelper.rW(35)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                        child: Text(
                          'Lưu',
                          style: context.textTheme.button
                              .copyWith(color: _theme.colorScheme.onPrimary),
                        ),
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
    final sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(
        title: params?.title ?? '',
        onBackPressed: () {
          if (isEdit) {
            _settingModalBottomSheet(context);
          } else {
            Router.pop(context);
          }
        },
        actions: [
          SaveButton(
            onPressed: () {
              params.onSave?.call(_textController.text);
              Router.pop(context);
            },
          )
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
                'Hiển thị trên hồ sơ của bạn',
                style: context.textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
