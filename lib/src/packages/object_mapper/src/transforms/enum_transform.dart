part of '../../object_mapper.dart';

class EnumTransform<Object extends Enumerable, JSON>
    with Transformable<Object, JSON> {
  @override
  Object fromJson(value) {
    if (value == null || !(value is JSON)) return null;
    return RawRepresentable(Object, value);
  }

  @override
  JSON toJson(Object value) {
    if (value == null) return null;
    return value.rawValue;
  }
}
