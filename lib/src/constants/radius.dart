part of 'values.dart';

class AppRadius {
  static const BorderRadius primaryRadius = BorderRadius.only(
    topLeft: Radius.circular(Sizes.RADIUS_30),
    topRight: Radius.circular(Sizes.RADIUS_30),
  );

  static const BorderRadius defaultButtonRadius = BorderRadius.only(
    topLeft: Radius.circular(Sizes.RADIUS_30),
    bottomLeft: Radius.circular(Sizes.RADIUS_30),
  );
}
