part of base;

extension ContextExt on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get size => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.width;
  double get width => MediaQuery.of(this).size.height;
}
