part of '../index.dart';

class SaveButton extends StatelessWidget {
  final Function onPressed;

  const SaveButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(Strings.button.save, style: context.textTheme.button),
      onPressed: onPressed,
    );
  }
}
