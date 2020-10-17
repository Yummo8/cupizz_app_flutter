part of base;

extension StringExt on String {
  bool get isExistAndNotEmpty => this != null && this.isNotEmpty;

  bool get isEmail {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}
