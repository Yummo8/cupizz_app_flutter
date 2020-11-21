part of '../index.dart';

class OptionButton extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Function onPressed;

  const OptionButton({
    Key key,
    this.onPressed,
    @required this.title,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = Text(title ?? '',
        style: context.textTheme.button.copyWith(
            color: !isSelected
                ? Colors.grey[500]
                : context.colorScheme.onPrimary));
    return isSelected
        ? RaisedButton(
            onPressed: () => onPressed?.call(),
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.onPrimary,
            child: child,
          )
        : OutlineButton(
            onPressed: () => onPressed?.call(),
            borderSide: BorderSide(width: 1, color: Colors.grey[500]),
            highlightColor: context.colorScheme.primary.withOpacity(0.5),
            child: child,
          );
  }
}
