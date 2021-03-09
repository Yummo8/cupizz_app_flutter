part of base;

extension NullableListExt<T> on List<T?>? {
  bool get isExistAndNotEmpty =>
      this != null && this!.isNotEmpty && this!.getAt(0) != null;
}

extension ListExt<T> on List<T?> {
  List<T?> addBetweenEvery(T value) {
    final r = [];
    asMap().forEach((i, e) => i < length - 1 ? r.addAll([e, value]) : r.add(e));
    return r as List<T?>;
  }

  T? getAt(int index) {
    if (length - 1 < index) return null;
    return elementAt(index);
  }

  List<K> mapIndexed<K>(K Function(T?, int) func) {
    return asMap()
        .map((key, value) => MapEntry(key, func(value, key)))
        .values
        .toList();
  }
}

extension ListExtNonNull<T> on List<T> {
  List<K> mapIndexed<K>(K Function(T, int) func) {
    return asMap()
        .map((key, value) => MapEntry(key, func(value, key)))
        .values
        .toList();
  }
}
