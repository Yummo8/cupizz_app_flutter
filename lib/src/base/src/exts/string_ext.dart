part of base;

extension StringExt on String {
  bool get isExistAndNotEmpty => this != null && isNotEmpty;

  DateTime toVietNameseDate() {
    try {
      return DateFormat('dd/MM/yyyy').parse(this);
    } catch (e) {
      debugPrint('Can\'t parse DateTime: $e');
      return null;
    }
  }
}
