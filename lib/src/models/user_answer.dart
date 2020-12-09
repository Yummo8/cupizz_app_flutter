part of 'index.dart';

class UserAnswer extends BaseModel {
  String _content;
  Color _color;
  Color _textColor;
  List<Color> _gradient;
  Question _question;

  String get content => _content;
  Color get color => _color;
  Color get textColor => _textColor;
  List<Color> get gradient => _gradient;
  Question get question => _question;

  ColorOfAnswer get colors => ColorOfAnswer(
        color: _color ?? _question.color,
        textColor: _textColor ?? _question.textColor,
        gradient: _gradient ?? _question.gradient,
      );

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('content', _content, (v) => _content = v);
    map('color', _color, (v) => _color = v, ColorTransform());
    map('textColor', _textColor, (v) => _textColor = v, ColorTransform());
    map<Color>('gradient', _gradient, (v) => _gradient = v, ColorTransform());
    map<Question>('question', _question, (v) => _question = v);
  }

  static String get graphqlQuery => '''{
          id
          color
          content
          textColor
          gradient
          question ${Question.graphqlQuery}
        }''';
}
