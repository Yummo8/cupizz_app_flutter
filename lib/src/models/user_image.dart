part of 'index.dart';

class UserImage with Mappable {
  FileModel _image;
  UserAnswer _answer;

  FileModel get image => _image;
  UserAnswer get answer => _answer;

  @override
  void mapping(Mapper map) {
    map<FileModel>('image', _image, (v) => _image = v);
    map<UserAnswer>('userAnswer', _answer, (v) => _answer = v);
  }

  static String get graphqlQuery => '''{
        image ${FileModel.graphqlQuery}
        userAnswer ${UserAnswer.graphqlQuery}
      }''';
}
