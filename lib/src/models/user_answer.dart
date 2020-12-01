part of 'index.dart';

class UserAnswer extends BaseModel {
  String _content;
  Color _color;
  Question _question;

  String get content => _content;
  Color get color => _color;
  Question get question => _question;

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('content', _content, (v) => _content = v);
    map('color', _color, (v) => _color = v, ColorTransform());
    map<Question>('question', _question, (v) => _question = v);
  }

  static String get graphqlQuery => '''{
          id
          color
          content
          question ${Question.graphqlQuery}
        }''';
}
