import 'package:cupizz_app/src/base/base.dart';

class CustomTheme extends InheritedWidget {
  CustomTheme({
    Key? key,
    required Widget child,
    required this.theme,
  }) : super(key: key, child: child);

  final ThemeData theme;

  static ThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomTheme>()!.theme;
  }

  @override
  bool updateShouldNotify(CustomTheme oldWidget) {
    var notSameTheme = oldWidget.theme != theme;
    return notSameTheme;
  }
}
