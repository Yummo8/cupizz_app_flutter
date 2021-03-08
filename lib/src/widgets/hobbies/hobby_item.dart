import 'package:cupizz_app/src/base/base.dart';

class HobbyItem extends StatelessWidget {
  final Hobby hobby;
  final bool isSelected;
  final Function([Hobby? hobby])? onPressed;

  const HobbyItem(
      {Key? key, required this.hobby, this.isSelected = false, this.onPressed})
      : super(key: key);

  void handlePressed(BuildContext context) {
    if (onPressed != null) {
      onPressed!(hobby);
    } else {
      Momentum.controller<CurrentUserController>(context)
          .toggleHobbyButton(hobby);
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = Text(hobby.value ?? '',
        style: context.textTheme.button!.copyWith(
            color: !isSelected
                ? Colors.grey[500]
                : context.colorScheme.onPrimary));
    return isSelected
        ? ElevatedButton(
            onPressed: () => handlePressed(context),
            style: ElevatedButton.styleFrom(
              primary: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.onPrimary,
            ),
            child: child,
          )
        : OutlinedButton(
            onPressed: () => handlePressed(context),
            style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 1,
                  color: Colors.grey[500]!,
                ),
                backgroundColor: context.colorScheme.primary.withOpacity(0.5)),
            child: child,
          );
  }
}
