part of base;

extension ListExt<T> on List<T> {
  bool get isExistAndNotEmpty => this != null && this.isNotEmpty;

  List<T> addBetweenEvery(T value) {
    List<T> r = [];
    this.asMap().forEach(
        (i, e) => i < this.length - 1 ? r.addAll([e, value]) : r.add(e));
    return r;
  }
}
