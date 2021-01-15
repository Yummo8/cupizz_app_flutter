import 'package:cupizz_app/src/base/base.dart';

class SaveButton extends StatelessWidget {
  final Function onPressed;
  final bool loading;
  final Color textColor;

  const SaveButton(
      {Key key, this.onPressed, this.textColor, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: loading
          ? LoadingIndicator(size: 12)
          : Icon(
              Icons.done,
              color: textColor ?? context.colorScheme.onBackground,
            ),
      onPressed: onPressed,
    );
  }
}

class SaveButtonAsync extends StatefulWidget {
  final Future Function() onPressed;

  const SaveButtonAsync({Key key, this.onPressed}) : super(key: key);

  @override
  _SaveButtonAsyncState createState() => _SaveButtonAsyncState();
}

class _SaveButtonAsyncState extends State<SaveButtonAsync> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: loading
          ? LoadingIndicator(size: 12)
          : Icon(
              Icons.done,
              color: context.colorScheme.onBackground,
            ),
      onPressed: widget.onPressed != null
          ? () async {
              setState(() {
                loading = true;
              });
              try {
                await widget.onPressed();
              } finally {
                if (mounted) {
                  setState(() {
                    loading = false;
                  });
                }
              }
            }
          : null,
    );
  }
}
