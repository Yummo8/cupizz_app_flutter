part of '../object_mapper.dart';

typedef void MappingSetter(dynamic value);
enum MappingType { fromJson, toJson }
enum ValueType { unknown, list, map, numeric, string, bool, dynamic }

class Mapper {
  MappingType _mappingType;
  Map<String, dynamic> json;

  // Constructor
  Mapper();

  Mapper.fromJson(this.json);

  T toObject<T>() {
    _mappingType = MappingType.fromJson;

    // Initialize an instance of T
    var instance = Mappable(T);
    if (instance == null) return null;

    // Call mapping for assigning value
    instance.mapping(this);

    return instance as T;
  }

  Map<String, dynamic> toJson(Mappable object) {
    json = {};
    _mappingType = MappingType.toJson;

    // Call mapping for assigning value to json
    object.mapping(this);

    return json;
  }

  /// This method will be used when a class
  /// implements the [Mappable.mapping] method
  dynamic call<T>(String field, dynamic value, MappingSetter setter,
      [Transformable transform]) {
    switch (_mappingType) {
      case MappingType.fromJson:
        _fromJson<T>(field, value, setter, transform);
        break;

      case MappingType.toJson:
        _toJson<T>(field, value, setter, transform);
        break;
    }
  }

  _fromJson<T>(String field, dynamic value, MappingSetter setter,
      [Transformable transform]) {
    List<String> subFields = field.split('.');
    var v = json[subFields[0]];
    for (var i = 1; i < subFields.length; i++) {
      v = v != null ? v[subFields[i]] : null;
    }
    final type = _getValueType(v);

    // Transform
    if (transform != null) {
      if (type == ValueType.list) {
        assert(
            T.toString() != "dynamic", "Missing type at mapping for `$field`");
        final list = List<T>();
        for (int i = 0; i < v.length; i++) {
          final item = transform.fromJson(v[i]);
          list.add(item);
        }
        setter(list);
      } else {
        v = transform.fromJson(v);
        setter(v);
      }

      return;
    }

    switch (type) {
      // List
      case ValueType.list:
        // Return it-self, if T is not set
        if (T.toString() == "dynamic") return setter(v);
        final list = List<T>();

        for (int i = 0; i < v.length; i++) {
          final item = _itemBuilder<T>(v[i], MappingType.fromJson);
          list.add(item);
        }

        setter(list);
        break;

      // Map
      case ValueType.map:
        setter(_itemBuilder<T>(v, MappingType.fromJson));
        break;

      default:
        setter(v);
    }
  }

  _toJson<T>(String field, dynamic value, MappingSetter setter,
      [Transformable transform]) {
    if (value == null) return;

    final type = _getValueType(value);
    var data;

    // Transform
    if (transform != null) {
      if (type == ValueType.list) {
        final list = List<dynamic>();
        for (int i = 0; i < value.length; i++) {
          final item = transform.toJson(value[i]);
          list.add(item);
        }
        data = list;
      } else {
        value = transform.toJson(value);
        data = value;
      }
    } else {
      switch (type) {
        // List
        case ValueType.list:
          final list = List();

          for (int i = 0; i < value.length; i++) {
            final item = _itemBuilder<T>(value[i], MappingType.toJson);
            list.add(item);
          }

          data = list;
          break;

        // Map
        case ValueType.map:
          data = value;
          break;

        default:
          data = value is Mappable ? value.toJson() : value;
      }
    }

    final List<String> subFields = field.split('.');
    this.json = _addSubFieldValue(this.json, subFields, data);
  }

  Map<String, dynamic> _addSubFieldValue(
      Map<String, dynamic> json, List<String> subFields, dynamic value) {
    assert(subFields.isNotEmpty);
    assert(json != null);

    final field = subFields[0];
    subFields.removeAt(0);

    if (subFields.isEmpty) {
      json[field] = value;
    } else {
      Map<String, dynamic> currentData = json[field] is! Map ? {} : json[field];

      currentData.addAll(_addSubFieldValue(currentData, subFields, value));

      json[field] = currentData;
    }

    return json;
  }

  ValueType _getValueType(object) {
    // Map
    if (object is Map) {
      return ValueType.map;
    }

    // List
    else if (object is List) {
      return ValueType.list;
    }

    // String
    else if (object is String) {
      return ValueType.string;
    }

    // Bool
    else if (object is bool) {
      return ValueType.bool;
    }

    // Numeric
    else if (object is int || object is double) {
      return ValueType.numeric;
    }

    // Dynamic
//		else if (object is dynamic) {
//			return ValueType.dynamic;
//		}

    return ValueType.unknown;
  }

  _itemBuilder<T>(value, MappingType mappingType) {
    // Should be numeric, bool, string.. some kind of single value
    if (T.toString() == "dynamic") {
      return value;
    }

    // Attempt to map it
    return mappingType == MappingType.fromJson
        ? Mapper.fromJson(value).toObject<T>()
        : Mapper().toJson(value);
  }
}
