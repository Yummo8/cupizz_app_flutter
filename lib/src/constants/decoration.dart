part of 'values.dart';

class Decorations {
  static BoxDecoration customBoxDecoration({
    double blurRadius = 5,
    Color color = const Color(0xFFD6D7FB),
  }) {
    return BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: blurRadius, color: color)]);
  }

  static const BoxDecoration primaryDecoration = BoxDecoration(
    color: DropAppColors.secondaryColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Sizes.RADIUS_30),
      topRight: Radius.circular(Sizes.RADIUS_30),
    ),
  );
}
