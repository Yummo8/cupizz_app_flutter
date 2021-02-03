import 'package:cupizz_app/src/base/base.dart';

class Post {
  int _id;
  String _content;
  PostCategory _category;
  DateTime _createdAt;
  int _commentCount;
  int _likeCount;
  int _loveCount;
  int _wowCount;
  int _hahaCount;
  int _angryCount;
  int _sadCount;
  LikeType _myLikedPostType;
  List<Comment> _comments;

  int get id => _id;
  String get content => _content;
  PostCategory get category => _category;
  DateTime get createdAt => _createdAt;
  int get commentCount => _commentCount;
  int get likeCount => _likeCount;
  int get loveCount => _loveCount;
  int get wowCount => _wowCount;
  int get hahaCount => _hahaCount;
  int get angryCount => _angryCount;
  int get sadCount => _sadCount;
  LikeType get myLikedPostType => _myLikedPostType;
  List<Comment> get comments => _comments;

  void mapping(Mapper map) {
    map('id', id, (v) => _id = v);
    map('content', content, (v) => _content = v);
    map('category', category, (v) => _category = v);
    map('createdAt', createdAt, (v) => _createdAt = v);
    map('commentCount', commentCount, (v) => _commentCount = v);
    map('likeCount', likeCount, (v) => _likeCount = v);
    map('loveCount', loveCount, (v) => _loveCount = v);
    map('wowCount', wowCount, (v) => _wowCount = v);
    map('hahaCount', hahaCount, (v) => _hahaCount = v);
    map('angryCount', angryCount, (v) => _angryCount = v);
    map('sadCount', sadCount, (v) => _sadCount = v);
    map('myLikedPostType', myLikedPostType, (v) => _myLikedPostType = v);
    map('comments', comments, (v) => _comments = v);
  }

  static String get graphqlQuery => '''
  {
    id
    content
    category ${PostCategory.graphqlQuery}
    createdAt
    commentCount
    likeCount: likeCount(type: like)
    hahaCount: likeCount(type: haha)
    loveCount: likeCount(type: love)
    wowCount: likeCount(type: wow)
    angryCount: likeCount(type: angry)
    sadCount: likeCount(type: sad)
    myLikedPostType
    comments(take: 10) ${Comment.graphqlQuery}
  }''';
}

class PostCategory extends BaseModel {
  String _value;
  Color _color;

  String get value => _value;
  Color get color => _color;

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('value', value, (v) => _value = v);
    map('color', color, (v) => _color = v, ColorTransform());
  }

  static String get graphqlQuery => '{ id value }';
}

class Comment extends BaseModel {
  int _index;
  String _content;
  DateTime _createdAt;

  int get index => _index;
  String get content => _content;
  DateTime get createdAt => _createdAt;

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('index', index, (v) => _index = v);
    map('content', content, (v) => _content = v);
    map('createdAt', createdAt, (v) => _createdAt = v, DateStringTransform());
  }

  static String get graphqlQuery => '{ id index content createdAt }';
}
