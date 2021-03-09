part of base;

extension StringExt on String? {
  bool get isExistAndNotEmpty => this != null && this!.isNotEmpty;

  DateTime? toVietNameseDate() {
    if (this == null) return null;
    try {
      return DateFormat('dd/MM/yyyy').parse(this!);
    } catch (e) {
      debugPrint('Can\'t parse DateTime: $e');
      return null;
    }
  }
}
