part of '../friend_page.dart';

class FriendPageModel extends MomentumModel<FriendPageController> {
  FriendPageModel(
    FriendPageController controller, {
    this.filter = FriendQueryType.all,
    this.sort = FriendQueryOrderBy.recent,
    this.isMultiColumn = true,
    this.friends = const [],
    this.scrollOffset = 0,
    this.currentPage = 1,
    this.isLastPage = false,
    this.isLoading = false,
  }) : super(controller);

  final FriendQueryType filter;
  final FriendQueryOrderBy sort;
  final bool isMultiColumn;
  final List<FriendData> friends;
  final double scrollOffset;
  final int currentPage;
  final bool isLastPage;

  final bool isLoading;

  @override
  void update({
    List<FriendData> friends,
    double scrollOffset,
    FriendQueryType filter,
    FriendQueryOrderBy sort,
    bool isMultiColumn,
    int currentPage,
    bool isLastPage,
    bool isLoading,
    int pageSize,
  }) {
    FriendPageModel(
      controller,
      friends: friends ?? this.friends,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      filter: filter ?? this.filter,
      sort: sort ?? this.sort,
      isMultiColumn: isMultiColumn ?? this.isMultiColumn,
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
      isLoading: isLoading ?? this.isLoading,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return FriendPageModel(
      controller,
      friends: ((json['friends'] ?? []) as List)
          .map((e) => Mapper.fromJson(e).toObject<FriendData>())
          .toList(),
      scrollOffset: json['scrollOffset'],
      filter: FriendQueryType(rawValue: json['filter']),
      sort: FriendQueryOrderBy(rawValue: json['sort']),
      isMultiColumn: json['isMultiColumn'],
      currentPage: json['currentPage'],
      isLastPage: json['isLastPage'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'friends': friends.map((e) => e.toJson()).toList(),
        'scrollOffset': scrollOffset,
        'filter': filter.rawValue,
        'sort': sort.rawValue,
        'isMultiColumn': isMultiColumn,
        'currentPage': currentPage,
        'isLastPage': isLastPage,
      };
}
