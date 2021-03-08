import 'package:cupizz_app/src/base/base.dart';

class ForgotPassOutput with Mappable {
  String? nickName;
  FileModel? avatar;
  String? token;

  @override
  void mapping(Mapper map) {
    map('nickName', nickName, (v) => nickName = v);
    map<FileModel>('avatar', avatar, (v) => avatar = v);
    map('token', token, (v) => token = v);
  }

  static String get graphqlQuery =>
      '''{ nickName token avatar ${FileModel.graphqlQuery} }''';
}
