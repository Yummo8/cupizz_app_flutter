import 'package:cupizz_app/src/base/base.dart';

class KeyValue extends BaseModel {
  String? _value;

  String? get value => _value;

  KeyValue({String? id, String? value})
      : _value = value,
        super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('value', _value, (v) => _value = v);
  }
}
