part of '../../object_mapper.dart';

class ColorTransform implements Transformable<Color, String> {
  ColorTransform();

  @override
  Color fromJson(value) {
    try {
      if (value is String) {
        return HexColor.fromHex(value, null);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  String toJson(Color value) {
    if (value == null) return null;

    return value.toHex(leadingHashSign: false);
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString, [Color fallbackColor]) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      if (fallbackColor != null) {
        return fallbackColor;
      } else {
        rethrow;
      }
    }
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
