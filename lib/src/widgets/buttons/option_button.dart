import 'package:cupizz_app/src/base/base.dart';

class OptionButton extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Function? onPressed;

  const OptionButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = Text(title,
        style: context.textTheme.button!.copyWith(
            color: !isSelected
                ? Colors.grey[500]
                : context.colorScheme.onPrimary));
    return isSelected
        ? ElevatedButton(
            onPressed: () => onPressed?.call(),
            style: ElevatedButton.styleFrom(
              primary: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.onPrimary,
            ),
            child: child,
          )
        : OutlinedButton(
            onPressed: () => onPressed?.call(),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 1,
                color: Colors.grey[500]!,
              ),
              primary: context.colorScheme.primary.withOpacity(0.5),
            ),
            child: child,
          );
  }
}
