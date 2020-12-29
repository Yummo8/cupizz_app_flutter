part of base;

extension ListExt<T> on List<T> {
  bool get isExistAndNotEmpty => this != null && isNotEmpty;

  List<T> addBetweenEvery(T value) {
    final r = [];
    asMap().forEach((i, e) => i < length - 1 ? r.addAll([e, value]) : r.add(e));
    return r;
  }

  T getAt(int index) {
    if (length - 1 < index) return null;
    return elementAt(index);
  }
}
