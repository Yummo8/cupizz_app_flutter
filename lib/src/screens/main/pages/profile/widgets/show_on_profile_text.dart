part of '../edit_profile_screen.dart';

class ShowOnProfileText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.common.showOnYourProfile,
      style: context.textTheme.bodyText2,
    );
  }
}
