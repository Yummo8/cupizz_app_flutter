import 'package:cupizz_app/src/models/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:object_mapper/object_mapper.dart';

final Map<String, dynamic> json = {
  'id': '0297e451-e1d0-4cb6-b4f4-26aa78d9e20e',
  'data': {
    'nickName': 'Aylin',
    'avatar': {
      'id': 'ckh6dj70c2390ayqsc22q0c9c',
      'type': 'image',
      'url': 'https://s3.amazonaws.com/uifaces/faces/twitter/her_ruu/128.jpg',
      'thumbnail':
          'https://s3.amazonaws.com/uifaces/faces/twitter/her_ruu/128.jpg'
    },
    'age': 39,
    'birthday': '1981-07-13T19:26:53.313Z',
    'introduction': 'Quia deleniti neque occaecati.',
    'gender': 'male',
    'hobbies': [
      {'id': 'ckh6dj2ik00179mqs4kx5g560', 'value': 'Mua sắm'},
      {
        'id': 'ckh6dj2jr00929mqsf6150qrb',
        'value': 'Đọc sách, báo, tiểu thuyết'
      },
      {'id': 'ckh6dj2jr00939mqsdvh7s92r', 'value': 'Vẽ tranh, Điêu khắc'},
      {
        'id': 'ckh6dj2jy01089mqstlhrd2uu',
        'value': 'Cho ăn và quan sát các loài chim địa phương'
      },
      {'id': 'ckh6dj2kg01409mqs98yyevm3', 'value': 'Sưu tầm'}
    ],
    'phoneNumber': '466-370-7134 x205',
    'job': 'Customer Communications Engineer',
    'height': 183,
    'minAgePrefer': 51,
    'maxAgePrefer': 67,
    'minHeightPrefer': 150,
    'maxHeightPrefer': 160,
    'genderPrefer': ['male', 'other'],
    'distancePrefer': 322,
    'friendType': {'status': 'me'},
    'onlineStatus': 'offline',
    'lastOnline': '2020-11-07T16:34:53.931Z',
    'settings': {
      'allowMatching': true,
      'isPrivate': false,
      'showActive': false
    },
    'socialProviders': [
      {'id': 'hienlh1298@gmail.com', 'type': 'email'}
    ]
  }
};

void main() {
  setUp(objectMapping);

  test('Test from json', () {
    var mapper = Mapper.fromJson(json);
    final user = mapper.toObject<User>();

    expect(user.id, json['id']);
    expect(user.nickName, json['data']['nickName']);
    expect(user.age, json['data']['age']);
    expect(user.introduction, json['data']['introduction']);
    expect(user.gender!.rawValue, json['data']['gender']);
    expect(
        user.hobbies!.map((e) => e.toJson()).toList(), json['data']['hobbies']);
    expect(user.phoneNumber, json['data']['phoneNumber']);
    expect(user.job, json['data']['job']);
    expect(user.height, json['data']['height']);
    expect(user.avatar!.toJson(), json['data']['avatar']);
    expect(user.onlineStatus!.rawValue, json['data']['onlineStatus']);
    expect(user.lastOnline, DateTime.tryParse(json['data']['lastOnline']));

    expect(user.birthday, DateTime.tryParse(json['data']['birthday']));
    expect(user.minAgePrefer, json['data']['minAgePrefer']);
    expect(user.maxAgePrefer, json['data']['maxAgePrefer']);
    expect(user.minHeightPrefer, json['data']['minHeightPrefer']);
    expect(user.maxHeightPrefer, json['data']['maxHeightPrefer']);
    expect(user.distancePrefer, json['data']['distancePrefer']);
    expect(user.genderPrefer!.map((e) => e.rawValue).toList(),
        json['data']['genderPrefer']);
    expect(user.friendType!.rawValue, json['data']['friendType']['status']);
    expect(user.allowMatching, json['data']['settings']['allowMatching']);
    expect(user.isPrivate, json['data']['settings']['isPrivate']);
    expect(user.showActive, json['data']['settings']['showActive']);
    expect(
        user.socialProviders![0].id, json['data']['socialProviders'][0]['id']);
  });

  test('Test to json', () {
    var mapper = Mapper.fromJson(json);
    final user = mapper.toObject<User>();
    final currentJson = user.toJson();

    expect(currentJson, json);
  });

  test('Test compare', () {
    var mapper = Mapper.fromJson(json);
    final user = mapper.toObject<User>();
    final clone = user.clone<User>();

    expect(clone == user, true);
  });
}
