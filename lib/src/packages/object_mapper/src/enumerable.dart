part of '../object_mapper.dart';

abstract class Enumerable<T> implements RawRepresentable<T> {
  const Enumerable();

  //
  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is RawRepresentable && rawValue == other.rawValue;
  }
}
