import 'package:flutter_test/flutter_test.dart';
import 'package:object_mapper/object_mapper.dart';

class UnregisteredInfo with Mappable {
  int id;
  String name;
  double rate;
  List<int> numbers;
  Map<String, dynamic> meta;
  NestedInfo nested;
  DateTime time;

  @override
  void mapping(Mapper map) {
    map('id', id, (v) => id = v);
    map('name', name, (v) => name = v);
    map('rate', rate, (v) => rate = v);
    map('meta', meta, (v) => meta = v);
    map<NestedInfo>('nested', nested, (v) => nested = v);
    map('time', time, (v) => time = v, DateTransform());
  }
}

class NonCorrectTestInfo with Mappable {
  bool isNothing;

  @override
  void mapping(Mapper map) {
    map('is_nothing', isNothing, (v) => isNothing = v);
  }
}

class TestInfo with Mappable {
  int id;
  bool isAdmin;
  String name;
  double rate;
  List<int> numbers;
  Map<String, dynamic> meta;
  NestedInfo nested;
  List<NestedInfo> nests;
  DateTime time;
  List<DateTime> times;
  bool likeNotification;

  @override
  void mapping(Mapper map) {
    map('id', id, (v) => id = v);
    map('is_admin', isAdmin, (v) => isAdmin = v);
    map('numbers', numbers, (v) => numbers = v.cast<int>());
    map('name', name, (v) => name = v);
    map('rate', rate, (v) => rate = v);
    map('meta', meta, (v) => meta = v);
    map<NestedInfo>('nested', nested, (v) => nested = v);
    map<NestedInfo>('nests', nests, (v) => nests = v);
    map('time', time, (v) => time = v, DateTransform());
    map<DateTime>('times', times, (v) => times = v, DateTransform());
    map('setting.notification.like', likeNotification,
        (v) => likeNotification = v);
  }
}

class NestedInfo with Mappable {
  int id;
  bool isAdmin;
  String name;
  double rate;
  List<int> numbers;
  Map<String, dynamic> meta;
  DateTime time;
  NestedInfo nested;
  List<NestedInfo> nests;

  @override
  void mapping(Mapper map) {
    map('id', id, (v) => id = v);
    map('is_admin', isAdmin, (v) => isAdmin = v);
    map('numbers', numbers, (v) => numbers = v.cast<int>());
    map('name', name, (v) => name = v);
    map('rate', rate, (v) => rate = v);
    map('meta', meta, (v) => meta = v);
    map('time', time, (v) => time = v, DateTransform());
    map<NestedInfo>('nested', nested, (v) => nested = v);
    map<NestedInfo>('nests', nests, (v) => nests = v);
  }
}

void expectInfo(Map<String, dynamic> json, info) {
  expect(info != null, true);
  expect(info.id, json['id']);
  expect(info.name, json['name']);
  expect(info.rate, json['rate']);
  expect(info.numbers, json['numbers']);
  expect(
      DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000)
          ?.compareTo(info.time),
      0);
  expect(info.isAdmin, json['is_admin']);
  expect(info.meta['empty'], 'no');
}

void expectJson(Map<String, dynamic> json, info) {
  expect(info.id, json['id']);
  expect(json['name'], info.name);
  expect(json['rate'], info.rate);
  expect(json['numbers'], info.numbers);
  expect(DateTime.tryParse(json['time'].toString())?.compareTo(info.time), 0);
  expect(json['is_admin'], info.isAdmin);
  expect(json['meta']['empty'], 'no');
}

void main() {
  setUp(() {
    Mappable.factories = {
      TestInfo: () => TestInfo(),
      NonCorrectTestInfo: () => NonCorrectTestInfo(),
      NestedInfo: () => NestedInfo()
    };
  });

  var jsonInput = <String, dynamic>{
    'id': 2,
    'name': 'mark',
    'is_admin': true,
    'rate': 2.3,
    'numbers': [2, 3],
    'time': 324,
    // second
    'times': [324, 325],
    'meta': {'empty': 'no'},
    'setting': {
      'notification': {'like': false}
    },
    'nested': {
      'id': 2,
      'name': 'mark',
      'is_admin': true,
      'rate': 2.3,
      'numbers': [2, 3],
      'time': 324,
      // second
      'meta': {'empty': 'no'},
      'nested': {
        'id': 2,
        'name': 'mark',
        'rate': 2.3,
        'numbers': [2, 3],
        'time': 324,
        'is_admin': true,
        'meta': {'empty': 'no'},
      },
      'nests': [
        {
          'id': 2,
          'name': 'mark',
          'rate': 2.3,
          'numbers': [2, 3],
          'time': 324,
          'is_admin': true,
          'meta': {'empty': 'no'},
        },
        {
          'id': 2,
          'name': 'mark',
          'rate': 2.3,
          'numbers': [2, 3],
          'time': 324,
          'is_admin': true,
          'meta': {'empty': 'no'},
        }
      ]
    },
    'nests': [
      {
        'id': 2,
        'name': 'mark',
        'rate': 2.3,
        'numbers': [2, 3],
        'time': 324,
        'meta': {'empty': 'no'},
        'is_admin': true,
      },
      {
        'id': 2,
        'name': 'mark',
        'rate': 2.3,
        'numbers': [2, 3],
        'time': 324,
        'meta': {'empty': 'no'},
        'is_admin': true,
      }
    ]
  };

  group('toObject', () {
    test('#1 Incorrect model class', () {
      var mapper = Mapper.fromJson(jsonInput);

      // non-correct info
      final nonCorrectInfo = mapper.toObject<NonCorrectTestInfo>();
      expect(nonCorrectInfo != null, true);
      expect(nonCorrectInfo.isNothing, null);
    });

    test('#2 Correct model class', () {
      var mapper = Mapper.fromJson(jsonInput);

      // correct info
      final json = mapper.json;
      final info = mapper.toObject<TestInfo>();
      expectInfo(json, info);
      expect(info.likeNotification, json['setting']['notification']['like']);
      expect(info.times, isNotNull);
      expect(info.times.length, equals(json['times'].length));
      expect(info.times.first.millisecondsSinceEpoch,
          equals(json['times'][0] * 1000));

      final nested = info.nested;
      expectInfo(json['nested'], nested);

      final nests = info.nests;
      expect(nests != null, true);
      expect(nests.length, json['nests'].length);
      nests.asMap().forEach((i, o) => expectInfo(json['nests'][i], o));
    });

    test('#3 Clone & compare', () {
      final info = Mapper.fromJson(jsonInput).toObject<TestInfo>();
      final clone = info.clone<TestInfo>();
      expect(clone == info, true);
    });
  });

  test('toJson', () {
    final repeatedNestedInfo = NestedInfo();
    repeatedNestedInfo.id = 2;
    repeatedNestedInfo.name = 'mark';
    repeatedNestedInfo.isAdmin = true;
    repeatedNestedInfo.rate = 2.3;
    repeatedNestedInfo.numbers = [2, 3];
    repeatedNestedInfo.time = DateTime.fromMillisecondsSinceEpoch(324 * 1000);
    repeatedNestedInfo.meta = {'empty': 'no'};

    final nestedInfo = NestedInfo();
    nestedInfo.id = 2;
    nestedInfo.name = 'mark';
    nestedInfo.isAdmin = true;
    nestedInfo.rate = 2.3;
    nestedInfo.numbers = [2, 3];
    nestedInfo.time = DateTime.fromMillisecondsSinceEpoch(324 * 1000);
    nestedInfo.meta = {'empty': 'no'};
    nestedInfo.nested = repeatedNestedInfo;
    nestedInfo.nests = [repeatedNestedInfo, repeatedNestedInfo];

    final info = TestInfo();
    info.id = 2;
    info.name = 'mark';
    info.isAdmin = true;
    info.rate = 2.3;
    info.numbers = [2, 3];
    info.time = DateTime.fromMillisecondsSinceEpoch(324 * 1000);
    info.times = [
      DateTime.fromMillisecondsSinceEpoch(324 * 1000),
      DateTime.fromMillisecondsSinceEpoch(325 * 1000)
    ];
    info.meta = {'empty': 'no'};
    info.nested = nestedInfo;
    info.nests = [repeatedNestedInfo, repeatedNestedInfo];
    info.likeNotification = false;

    final jsonOutput = Mapper().toJson(info);
    expectJson(jsonOutput, info);
    expect(jsonOutput['times'], isNotNull);
    expect(jsonOutput['times'].length, equals(2));
    expect(
        DateTime.tryParse(jsonOutput['times'][0])
            .compareTo(DateTime.fromMillisecondsSinceEpoch(324 * 1000)),
        0);
    expect(jsonOutput['setting']['notification']['like'], false);

    final nested = info.nested;
    expectJson(jsonOutput['nested'], nested);

    final nests = info.nests;
    expect(nests != null, true);
    expect(jsonOutput['nests'].length, nests.length);
    nests.asMap().forEach((i, o) => expectJson(jsonOutput['nests'][i], o));
  });
}
