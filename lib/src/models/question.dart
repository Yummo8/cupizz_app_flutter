import 'package:cupizz_app/src/base/base.dart';

class Question extends BaseModel {
  String? _content;
  Color? _color;
  Color? _textColor;
  List<Color>? _gradient;

  String? get content => _content;
  Color? get color => _color;
  Color? get textColor => _textColor;
  List<Color>? get gradient => _gradient;

  ColorOfAnswer get colors => ColorOfAnswer(
        color: _color ?? ColorOfAnswer.defaultColor.color,
        textColor: _textColor ?? ColorOfAnswer.defaultColor.textColor,
        gradient: _gradient ?? ColorOfAnswer.defaultColor.gradient,
      );

  Question({String? id, String? content})
      : _content = content,
        super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('content', _content, (v) => _content = v);
    map('color', _color, (v) => _color = v, ColorTransform());
    map('color', _color, (v) => _color = v, ColorTransform());
  }

  static String get graphqlQuery => '{ id content color textColor gradient }';
}
