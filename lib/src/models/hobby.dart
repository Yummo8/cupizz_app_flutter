part of 'index.dart';

class Hobby extends KeyValue {
  Hobby({String id, String value}) : super(id: id, value: value);

  static String get graphqlQuery => '{id value}';
}
