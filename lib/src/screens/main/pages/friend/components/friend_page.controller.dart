part of '../friend_page.dart';

enum FriendPageEventAction {
  error,
}

class FriendPageEvent {
  final FriendPageEventAction action;
  final String message;

  FriendPageEvent({@required this.action, this.message});
}

class FriendPageController extends MomentumController<FriendPageModel> {
  @override
  FriendPageModel init() {
    return FriendPageModel(this);
  }

  @override
  bootstrapAsync() => _reloadFriends();

  Future refresh() => _reloadFriends();

  Future updateSettings({
    FriendQueryType filter,
    FriendQueryOrderBy sort,
    bool isMultiColumn,
  }) async {
    if (filter != null || sort != null || isMultiColumn != null) {
      this.model.update(
            isLoading: true,
            filter: filter,
            sort: sort,
            isMultiColumn: isMultiColumn,
          );
      await _reloadFriends();
      this.model.update(isLoading: false);
    }
  }

  Future loadmoreFriends() async {
    try {
      final friends = await getService<UserService>().getFriends(
        type: this.model.filter,
        orderBy: this.model.sort,
        page: this.model.currentPage + 1,
      );
      this.model.friends.addAll(friends);

      this.model.update(
            friends: this.model.friends,
            currentPage: this.model.currentPage + 1,
            isLastPage: friends.isEmpty || this.model.pageSize > friends.length,
          );
    } catch (e) {
      sendEvent(FriendPageEvent(
          action: FriendPageEventAction.error, message: e.toString()));
    }
  }

  Future _reloadFriends() async {
    try {
      final friends = await getService<UserService>().getFriends(
        type: this.model.filter,
        orderBy: this.model.sort,
        page: 1,
      );
      this.model.update(
            friends: friends,
            currentPage: 1,
            isLastPage: friends.length == 0,
            pageSize: friends.length,
          );
    } catch (e) {
      sendEvent(FriendPageEvent(
          action: FriendPageEventAction.error, message: e.toString()));
    }
  }
}
