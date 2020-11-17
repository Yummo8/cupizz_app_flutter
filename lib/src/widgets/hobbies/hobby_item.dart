part of '../index.dart';

class HobbyItem extends StatelessWidget {
  final Hobby hobby;
  final bool isSelected;
  final Function([Hobby hobby]) onPressed;

  const HobbyItem(
      {Key key, @required this.hobby, this.isSelected = false, this.onPressed})
      : super(key: key);

  handlePressed(BuildContext context) {
    if (onPressed != null) {
      onPressed(hobby);
    } else {
      Momentum.controller<CurrentUserController>(context)
          .toggleHobbyButton(hobby);
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = hobby == null
        ? const SizedBox.shrink()
        : Text(hobby.value,
            style: context.textTheme.button.copyWith(
                color: !isSelected
                    ? Colors.grey[500]
                    : context.colorScheme.onPrimary));
    return hobby == null
        ? const SizedBox.shrink()
        : isSelected
            ? RaisedButton(
                onPressed: () => handlePressed(context),
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.onPrimary,
                child: child,
              )
            : OutlineButton(
                onPressed: () => handlePressed(context),
                borderSide: BorderSide(width: 1, color: Colors.grey[500]),
                highlightColor: context.colorScheme.primary.withOpacity(0.5),
                child: child,
              );
  }
}
