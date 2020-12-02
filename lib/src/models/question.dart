part of 'index.dart';

class Question extends BaseModel {
  String _content;
  Color _color;

  String get content => _content;
  Color get color => _color;

  Question({String id, String content})
      : _content = content,
        super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('content', _content, (v) => _content = v);
    map('color', _color, (v) => _color = v, ColorTransform());
  }

  static String get graphqlQuery => '{ id content color }';
}
