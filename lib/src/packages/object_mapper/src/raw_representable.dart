part of '../object_mapper.dart';

abstract class RawRepresentable<RawValue> {
  final RawValue rawValue;

  factory RawRepresentable(Type type, RawValue rawValue) {
    var constructor = Mappable.factories[type];
    if (constructor == null) return null;
    return constructor(rawValue);
  }
}
