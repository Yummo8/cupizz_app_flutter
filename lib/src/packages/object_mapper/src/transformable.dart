part of '../object_mapper.dart';

abstract class Transformable<Object, JSON> {
  Object fromJson(dynamic value);

  JSON toJson(Object value);
}
