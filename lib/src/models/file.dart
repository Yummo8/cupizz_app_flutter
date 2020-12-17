part of 'index.dart';

class FileModel extends BaseModel {
  FileType _type;
  String _url;
  String _thumbnail;

  String get url => _url;
  String get thumbnail => _thumbnail ?? url;

  FileModel({String id, FileType type, String url, String thumbnail})
      : _type = type,
        _thumbnail = thumbnail,
        _url = url,
        super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('type', _type, (v) => _type = v, EnumTransform<FileType, String>());
    map('url', _url, (v) => _url = v);
    map('thumbnail', _thumbnail, (v) => _thumbnail = v);
  }

  static String get graphqlQuery => '{id type url thumbnail}';
}
