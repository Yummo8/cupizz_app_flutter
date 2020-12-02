part of '../../base.dart';

extension DateTimeExt on DateTime {
  String toVietNamese({bool withTime = false}) =>
      DateFormat('${withTime ? 'hh:mm ' : ''}dd/MM/yyyy').format(this);

  DateTime removeTime() => toVietNamese().toVietNameseDate();

  int getAge() {
    return DateTime.now().year - year;
  }
}
