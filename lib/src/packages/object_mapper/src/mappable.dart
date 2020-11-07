part of '../object_mapper.dart';

abstract class Mappable {
  static Map<Type, Function> factories = {};

  factory Mappable(Type type) {
    var constructor = Mappable.factories[type];
    assert(constructor != null,
        "${type.toString()} is not defined in Reflection.factories");
    return constructor();
  }

  void mapping(Mapper map);

  Map<String, dynamic> toJson() {
    return Mapper().toJson(this);
  }

  String toJsonString() {
    return json.encode(this.toJson());
  }
}
