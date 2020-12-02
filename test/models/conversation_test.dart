import 'package:cupizz_app/src/models/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:object_mapper/object_mapper.dart';

final Map<String, dynamic> json = {
  'id': 'ckhsn40e900044rnxna4onhsj',
  'data': {
    'name': 'Jan Tăng',
    'images': [
      {
        'id': 'ckhj9mdp55060awmswdrxfemk',
        'type': 'image',
        'url': 'https://loremflickr.com/623/492/girl?lock=9584',
        'thumbnail': 'https://loremflickr.com/623/492/girl?lock=9584'
      }
    ],
    'newestMessage': {
      'id': 'ckhsn4mf800174rnxz2l7uru2',
      'message': '123',
      'createdAt': '2020-11-22T04:48:01.412Z',
      'updatedAt': '2020-11-22T04:48:01.413Z',
      'attachments': [],
      'sender': {
        'id': '0297e451-e1d0-4cb6-b4f4-26aa78d9e20e',
        'data': {
          'nickName': 'Aylin',
          'age': 39,
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
          'avatar': {
            'id': 'ckh6dj70c2390ayqsc22q0c9c',
            'type': 'image',
            'url':
                'https://s3.amazonaws.com/uifaces/faces/twitter/her_ruu/128.jpg',
            'thumbnail':
                'https://s3.amazonaws.com/uifaces/faces/twitter/her_ruu/128.jpg'
          },
          'friendType': {'status': 'none'},
          'onlineStatus': 'offline',
          'lastOnline': '2020-11-07T16:34:53.931Z',
        }
      }
    },
    'onlineStatus': 'offline'
  },
  'personalData': {'unreadMessageCount': 0}
};

void main() {
  setUp(objectMapping);

  test('Test from json', () {
    var mapper = Mapper.fromJson(json);
    final conversation = mapper.toObject<Conversation>();

    expect(conversation.id, json['id']);
    expect(conversation.name, json['data']['name']);
    expect(conversation.images.map((e) => e.toJson()).toList(),
        json['data']['images']);
    expect(conversation.newestMessage.toJson(), json['data']['newestMessage']);
    expect(conversation.onlineStatus.rawValue, json['data']['onlineStatus']);
    expect(conversation.unreadMessageCount,
        json['personalData']['unreadMessageCount']);
  });

  test('Test to json', () {
    var mapper = Mapper.fromJson(json);
    final conversation = mapper.toObject<Conversation>();
    final currentJson = conversation.toJson();

    expect(currentJson, json);
  });

  test('Test compare', () {
    var mapper = Mapper.fromJson(json);
    final conversation = mapper.toObject<Conversation>();
    final clone = conversation.clone<Conversation>();

    expect(clone == conversation, true);
  });
}
