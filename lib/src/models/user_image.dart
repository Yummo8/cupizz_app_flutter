part of 'index.dart';

class UserImage extends BaseModel {
  FileModel _image;
  UserAnswer _answer;
  int _sortOrder;

  FileModel get image => _image;
  UserAnswer get answer => _answer;
  int get sortOrder => _sortOrder;

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map<FileModel>('image', _image, (v) => _image = v);
    map<UserAnswer>('userAnswer', _answer, (v) => _answer = v);
    map('sortOrder', _sortOrder, (v) => _sortOrder = v);
  }

  static String get graphqlQuery => '''{
        id
        image ${FileModel.graphqlQuery}
        userAnswer ${UserAnswer.graphqlQuery}
        sortOrder
      }''';
}
