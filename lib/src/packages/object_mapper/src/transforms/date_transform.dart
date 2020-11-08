part of '../../object_mapper.dart';

class DateUnit extends Enumerable<int> {
  final int rawValue;
  const DateUnit({@required this.rawValue});

  //
  static const seconds = const DateUnit(rawValue: 1000);
  static const milliseconds = const DateUnit(rawValue: 1);

  double addScale(double interval) {
    return interval * rawValue;
  }

  double removeScale(double interval) {
    return interval / rawValue;
  }
}

class DateTransform implements Transformable<DateTime, String> {
  DateUnit unit;
  DateTransform({this.unit = DateUnit.seconds});

  //
  @override
  DateTime fromJson(value) {
    try {
      if (value == null) return null;
      if (value is String) return DateTime.parse(value);
      if (value is int) value = value.toDouble();
      if (value < 0) return null;

      return DateTime.fromMillisecondsSinceEpoch(unit.addScale(value).toInt());
    } catch (e) {
      return null;
    }
  }

  @override
  String toJson(DateTime value) {
    if (value == null) return null;

    return value.toUtc().toIso8601String();
  }
}
