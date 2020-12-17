part of 'index.dart';

class Hobby extends KeyValue {
  Hobby({String id, String value}) : super(id: id, value: value);

  static String get graphqlQuery => '{id value}';
}

class HobbyWithIsSelect implements Comparable<HobbyWithIsSelect> {
  final bool isSelected;
  final Hobby hobby;

  HobbyWithIsSelect(this.hobby, this.isSelected);

  @override
  int compareTo(HobbyWithIsSelect other) => hobby.compareTo(other.hobby);
}
