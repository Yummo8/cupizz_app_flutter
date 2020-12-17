part of '../friend_page_v2.dart';

class FriendV2TabData with Mappable {
  List<FriendData> _friends = const [];
  bool _isLastPage = false;
  int _currentPage = 1;
  FriendQueryOrderBy _sort = FriendQueryOrderBy.recent;

  List<FriendData> get friends => _friends;
  bool get isLastPage => _isLastPage;
  int get currentPage => _currentPage;
  FriendQueryOrderBy get sort => _sort;

  FriendV2TabData({
    List<FriendData> friends,
    bool isLastPage,
    int currentPage,
    FriendQueryOrderBy sort,
  })  : _friends = friends,
        _isLastPage = isLastPage,
        _currentPage = currentPage,
        _sort = sort;

  void addData(FriendV2TabData data) {
    _friends.addAll(data.friends);
    _currentPage = data.currentPage;
    _isLastPage = data.isLastPage;
  }

  FriendV2TabData copyWith({
    List<FriendData> friends,
    bool isLastPage,
    int currentPage,
    FriendQueryOrderBy sort,
  }) {
    _friends = friends ?? this.friends;
    _isLastPage = isLastPage ?? this.isLastPage;
    _currentPage = currentPage ?? this.currentPage;
    _sort = sort ?? this.sort;
    return this;
  }

  @override
  void mapping(Mapper map) {
    map<FriendData>('friends', friends, (v) => _friends = v);
    map('_isLastPage', _isLastPage, (v) => _isLastPage = v);
    map('_currentPage', _currentPage, (v) => _currentPage = v);
    map('_sort', _sort, (v) => _sort = v,
        EnumTransform<FriendQueryOrderBy, String>());
  }
}

class FriendPageModel extends MomentumModel<FriendPageController> {
  FriendPageModel(
    FriendPageController controller, {
    this.allFriends,
    this.receivedFriends,
    this.scrollOffset = 0,
    this.animationController,
    this.currentTab = 0,
  }) : super(controller);

  final FriendV2TabData allFriends;
  final FriendV2TabData receivedFriends;
  final double scrollOffset;
  final int currentTab;

  final AnimationController animationController;

  @override
  void update({
    FriendV2TabData allFriends,
    FriendV2TabData receivedFriends,
    double scrollOffset,
    AnimationController animationController,
    int currentTab,
  }) {
    FriendPageModel(
      controller,
      allFriends: allFriends ?? this.allFriends,
      receivedFriends: receivedFriends ?? this.receivedFriends,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      animationController: animationController ?? this.animationController,
      currentTab: currentTab ?? this.currentTab,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return FriendPageModel(
      controller,
      allFriends:
          Mapper.fromJson(json['allFriends']).toObject<FriendV2TabData>(),
      receivedFriends:
          Mapper.fromJson(json['receivedFriends']).toObject<FriendV2TabData>(),
      scrollOffset: json['scrollOffset'],
      currentTab: json['currentTab'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'allFriends': allFriends.toJson(),
        'receivedFriends': receivedFriends.toJson(),
        'scrollOffset': scrollOffset,
        'currentTab': currentTab,
      };
}
