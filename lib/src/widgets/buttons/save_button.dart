part of '../index.dart';

class SaveButton extends StatelessWidget {
  final Function onPressed;
  final bool loading;

  const SaveButton({Key key, this.onPressed, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: loading
          ? LoadingIndicator(size: 12)
          : Icon(
              Icons.done,
              color: context.colorScheme.onBackground,
            ),
      onPressed: onPressed,
    );
  }
}
