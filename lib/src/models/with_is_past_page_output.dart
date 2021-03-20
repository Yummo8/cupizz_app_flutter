import 'package:cupizz_app/src/base/base.dart';

class WithIsLastPageOutput<T extends Mappable> {
  List<T>? _data;
  bool? _isLastPage;

  List<T>? get data => _data;
  bool? get isLastPage => _isLastPage;
  T? get last => _data?.getAt((_data?.length ?? 1) - 1);
  T? get first => _data?.getAt(0);

  WithIsLastPageOutput({
    List<T>? data,
    bool? isLastPage,
  })  : _data = data,
        _isLastPage = isLastPage;

  factory WithIsLastPageOutput.fromJson(Map<String, dynamic>? json) {
    if (json == null) return WithIsLastPageOutput();
    return WithIsLastPageOutput(
      data: (json['data'] as List)
          .map((e) => Mapper.fromJson(e).toObject<T>())
          .toList(),
      isLastPage: json['isLastPage'],
    );
  }

  void add(WithIsLastPageOutput<T> other) {
    _data!.addAll(other._data!);
    _isLastPage = other._isLastPage;
  }

  Map<String, dynamic> toJson() => {
        'data': data!.map((e) => e.toJson()).toList(),
        'isLastPage': isLastPage,
      };

  static String graphqlQuery(String dataQuery) =>
      '{data $dataQuery isLastPage}';
}
