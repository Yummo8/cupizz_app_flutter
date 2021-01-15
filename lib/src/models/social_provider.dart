import 'package:cupizz_app/src/base/base.dart';

class SocialProvider extends BaseModel {
  SocialProviderType _type;
  SocialProviderType get type => _type;

  SocialProvider({String id, SocialProviderType type})
      : _type = type,
        super(id: id);

  static String get graphqlQuery => '{id type}';

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('type', _type, (v) => _type = v,
        EnumTransform<SocialProviderType, String>());
  }
}
