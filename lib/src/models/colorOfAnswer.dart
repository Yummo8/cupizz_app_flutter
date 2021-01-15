import 'package:cupizz_app/src/base/base.dart';

class ColorOfAnswer with Mappable {
  Color _color;
  List<Color> _gradient;
  Color _textColor;

  Color get color => _color;
  List<Color> get gradient => _gradient;
  Color get textColor => _textColor;

  ColorOfAnswer({
    Color color,
    List<Color> gradient,
    Color textColor,
  })  : _color = color,
        _gradient = gradient,
        _textColor = textColor;

  @override
  void mapping(Mapper map) {
    map('color', _color, (v) => _color = v, ColorTransform());
    map<Color>('gradient', _gradient, (v) => _gradient = v, ColorTransform());
    map('textColor', _textColor, (v) => _textColor = v, ColorTransform());
  }

  static ColorOfAnswer get defaultColor => ColorOfAnswer()
    .._color = Colors.grey
    .._textColor = Colors.white;

  static String get graphqlQuery => '{ color gradient textColor }';
}
