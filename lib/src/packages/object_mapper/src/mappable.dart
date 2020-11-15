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

  T clone<T extends Mappable>() {
    final json = this.toJson();
    return Mapper.fromJson(json).toObject<T>();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mappable &&
          runtimeType == other.runtimeType &&
          this.toJsonString() == other.toJsonString();

  @override
  int get hashCode => runtimeType.hashCode ^ this.toJson().hashCode;

  String toJsonString() {
    return json.encode(this.toJson());
  }
}
