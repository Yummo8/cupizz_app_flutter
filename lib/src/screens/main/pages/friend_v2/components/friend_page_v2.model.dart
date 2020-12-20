part of '../friend_page_v2.dart';

class FriendV2TabData with Mappable {
  List<FriendData> _friends = const [];
  bool _isLastPage = false;
  int _currentPage = 1;
  FriendQueryOrderBy _sort = FriendQueryOrderBy.recent;
  bool _isLoadingMore = false;

  List<FriendData> get friends => _friends;
  bool get isLastPage => _isLastPage;
  int get currentPage => _currentPage;
  FriendQueryOrderBy get sort => _sort;
  bool get isLoadingMore => _isLoadingMore ?? false;

  FriendV2TabData({
    List<FriendData> friends,
    bool isLastPage,
    int currentPage,
    FriendQueryOrderBy sort,
    bool isLoadingMore,
  })  : _friends = friends,
        _isLastPage = isLastPage,
        _isLoadingMore = isLoadingMore,
        _currentPage = currentPage,
        _sort = sort;

  void addData(FriendV2TabData data) {
    _friends.addAll(data.friends);
    _currentPage = data.currentPage;
    _isLastPage = data.isLastPage;
    _isLoadingMore = data.isLoadingMore;
  }

  FriendV2TabData copyWith({
    List<FriendData> friends,
    bool isLastPage,
    int currentPage,
    FriendQueryOrderBy sort,
    bool isLoadingMore,
  }) {
    _friends = friends ?? this.friends;
    _isLastPage = isLastPage ?? this.isLastPage;
    _currentPage = currentPage ?? this.currentPage;
    _sort = sort ?? this.sort;
    _isLoadingMore = isLoadingMore ?? this.isLoadingMore;
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

class FriendPageV2Model extends MomentumModel<FriendPageV2Controller> {
  FriendPageV2Model(
    FriendPageV2Controller controller, {
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
    FriendPageV2Model(
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
    return FriendPageV2Model(
      controller,
      allFriends: json['allFriends'] == null
          ? FriendV2TabData()
          : Mapper.fromJson(json['allFriends']).toObject<FriendV2TabData>(),
      receivedFriends: json['receivedFriends'] == null
          ? FriendV2TabData()
          : Mapper.fromJson(json['receivedFriends'])
              .toObject<FriendV2TabData>(),
      scrollOffset: json['scrollOffset'],
      currentTab: json['currentTab'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'allFriends': (allFriends ?? FriendV2TabData())?.toJson(),
        'receivedFriends': (receivedFriends ?? FriendV2TabData())?.toJson(),
        'scrollOffset': scrollOffset,
        'currentTab': currentTab,
      };
}
