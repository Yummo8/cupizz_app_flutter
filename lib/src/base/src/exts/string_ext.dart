part of base;

extension StringExt on String {
  bool get isExistAndNotEmpty => this != null && this.isNotEmpty;

  bool get isEmail {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  DateTime toVietNameseDate() {
    try {
      return DateFormat('dd/MM/yyyy').parse(this);
    } catch (e) {
      debugPrint('Can\'t parse DateTime: $e');
      return null;
    }
  }
}
