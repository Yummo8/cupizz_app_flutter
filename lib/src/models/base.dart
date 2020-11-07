part of 'index.dart';

class BaseModel with Mappable implements Comparable<BaseModel> {
  String _id;

  String get id => _id;

  BaseModel({String id}) : _id = id;

  int compareTo(BaseModel other) => this.id.compareTo(other.id);

  @override
  void mapping(Mapper map) {
    map('id', _id, (v) => _id = v);
  }
}
