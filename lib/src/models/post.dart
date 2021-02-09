import 'package:cupizz_app/src/base/base.dart';

class Post with Mappable {
  int _id;
  String _content;
  PostCategory _category;
  DateTime _createdAt;
  int commentCount;
  int likeCount;
  int _loveCount;
  int _wowCount;
  int _hahaCount;
  int _angryCount;
  int _sadCount;
  LikeType myLikedPostType;
  List<Comment> _comments;
  List<FileModel> _images;

  int get id => _id;
  String get content => _content;
  PostCategory get category => _category;
  DateTime get createdAt => _createdAt;
  int get loveCount => _loveCount ?? 0;
  int get wowCount => _wowCount ?? 0;
  int get hahaCount => _hahaCount ?? 0;
  int get angryCount => _angryCount ?? 0;
  int get sadCount => _sadCount ?? 0;
  List<Comment> get comments => _comments;
  List<FileModel> get images => _images;

  int get totalReaction =>
      likeCount + loveCount + wowCount + hahaCount + angryCount + sadCount;

  @override
  void mapping(Mapper map) {
    map('id', id, (v) => _id = v);
    map('content', content, (v) => _content = v);
    map<PostCategory>('category', category, (v) => _category = v);
    map('createdAt', createdAt, (v) => _createdAt = v, DateStringTransform());
    map('commentCount', commentCount, (v) => commentCount = v ?? 0);
    map('likeCount', likeCount, (v) => likeCount = v ?? 0);
    map('loveCount', loveCount, (v) => _loveCount = v);
    map('wowCount', wowCount, (v) => _wowCount = v);
    map('hahaCount', hahaCount, (v) => _hahaCount = v);
    map('angryCount', angryCount, (v) => _angryCount = v);
    map('sadCount', sadCount, (v) => _sadCount = v);
    map('myLikedPostType', myLikedPostType, (v) => myLikedPostType = v,
        EnumTransform<LikeType, String>());
    map<Comment>('comments', comments, (v) => _comments = v);
    map<FileModel>('images', images, (v) => _images = v);
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
    comments${Comment.listFilter()} ${Comment.graphqlQuery}
    images ${FileModel.graphqlQuery}
  }''';
}

class PostCategory extends BaseModel {
  String _value;
  Color _color;

  String get value => _value ?? '';
  Color get color => _color ?? Colors.white;

  PostCategory({
    String id,
    String value,
    Color color,
  })  : _value = value,
        _color = color,
        super(id: id);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('value', value, (v) => _value = v);
    map('color', color, (v) => _color = v, ColorTransform());
  }

  static String get graphqlQuery => '{ id value color }';
}

class Comment extends BaseModel {
  int _index;
  String _content;
  DateTime _createdAt;
  ChatUser _createdBy;

  int get index => _index;
  String get content => _content;
  DateTime get createdAt => _createdAt;
  ChatUser get createdBy => _createdBy;

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map('index', index, (v) => _index = v);
    map('content', content, (v) => _content = v);
    map('createdAt', createdAt, (v) => _createdAt = v, DateStringTransform());
    map<ChatUser>('createdBy', createdBy, (v) => _createdBy = v);
  }

  static String get graphqlQuery =>
      '{ id index content createdAt createdBy ${ChatUser.graphqlQuery} }';
  static String listFilter({String cursorId}) => '''(
        take: ${PageSizeConst.comment} 
        ${cursorId.isExistAndNotEmpty ? 'cursor: { id: "$cursorId" } ' : ''}
        orderBy: {updatedAt: desc}
        skip: ${cursorId.isExistAndNotEmpty ? 1 : 0}
      )''';
}
