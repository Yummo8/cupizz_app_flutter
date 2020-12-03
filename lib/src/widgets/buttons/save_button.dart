part of '../index.dart';

class SaveButton extends StatelessWidget {
  final Function onPressed;

  const SaveButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.done,
        color: context.colorScheme.onBackground,
      ),
      onPressed: onPressed,
    );
  }
}
