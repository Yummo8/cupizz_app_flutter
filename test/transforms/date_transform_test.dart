import 'package:flutter_test/flutter_test.dart';
import 'package:object_mapper/object_mapper.dart';

void main() {
  group('fromJson', () {
    test('#1 Input is string', () {
      final transform = DateTransform();

      // null
      var date = transform.fromJson(null);
      expect(date, null);

      // full date string
      date = transform.fromJson('2019-02-02 02:00:00');
      expect(date, DateTime(2019, 2, 2, 2, 0, 0));

      // non-full date string
      date = transform.fromJson('2019-02-02 02:00');
      expect(date, DateTime(2019, 2, 2, 2, 0));

      // haft date string
      date = transform.fromJson('2019-02-02');
      expect(date, DateTime(2019, 2, 2));

      // empty
      date = transform.fromJson('');
      expect(date, null);

      // wrong string
      date = transform.fromJson('wrong');
      expect(date, null);
    });

    test('#2 Input in seconds', () {
      final transform = DateTransform();

      // int
      var date = transform.fromJson(324);
      expect(date, DateTime.fromMillisecondsSinceEpoch(324 * 1000));

      // double
      date = transform.fromJson(324.0);
      expect(date, DateTime.fromMillisecondsSinceEpoch(324 * 1000));

      // zero
      date = transform.fromJson(0);
      expect(date, DateTime.fromMillisecondsSinceEpoch(0 * 1000));

      // negative
      date = transform.fromJson(-1);
      expect(date, null);
    });

    test('#3 Input in milliseconds', () {
      final transform = DateTransform(unit: DateUnit.milliseconds);

      // int
      var date = transform.fromJson(324);
      expect(date, DateTime.fromMillisecondsSinceEpoch(324));

      // double
      date = transform.fromJson(324.0);
      expect(date, DateTime.fromMillisecondsSinceEpoch(324));

      // zero
      date = transform.fromJson(0);
      expect(date, DateTime.fromMillisecondsSinceEpoch(0));

      // negative
      date = transform.fromJson(-1);
      expect(date, null);
    });
  });

  group('toJson', () {
    test('#1 Input is string', () {
      final transform = DateTransform();

      // full date string
      var date = DateTime(2019, 2, 2, 2, 12, 33);
      expect(transform.toJson(date),
          DateTime(2019, 2, 2, 2, 12, 33).millisecondsSinceEpoch / 1000);

      // non-full date string
      date = DateTime(2019, 2, 2, 2, 0, 12);
      expect(transform.toJson(date),
          DateTime(2019, 2, 2, 2, 0, 12).millisecondsSinceEpoch / 1000);

      // haft date string
      date = DateTime(2019, 2, 2);
      expect(transform.toJson(date),
          DateTime(2019, 2, 2).millisecondsSinceEpoch / 1000);
    });

    test('#2 Input in seconds', () {
      final transform = DateTransform();

      // numeric
      var date = DateTime.fromMillisecondsSinceEpoch(324 * 1000);
      expect(transform.toJson(date), 324);

      // zero
      date = DateTime.fromMillisecondsSinceEpoch(0 * 1000);
      expect(transform.toJson(date), 0);

      // null
      expect(transform.toJson(null), null);
    });

    test('#3 Input is milliseconds', () {
      final transform = DateTransform(unit: DateUnit.milliseconds);

      // numeric
      var date = DateTime.fromMillisecondsSinceEpoch(324);
      expect(transform.toJson(date), 324);

      // zero
      date = DateTime.fromMillisecondsSinceEpoch(0);
      expect(transform.toJson(date), 0);

      // null
      expect(transform.toJson(null), null);
    });
  });
}
