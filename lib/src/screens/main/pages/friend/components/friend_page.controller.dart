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
    if (this.model.isLastPage) return;
    try {
      final result = await getService<UserService>().getFriendsV2(
        type: this.model.filter,
        orderBy: this.model.sort,
        page: this.model.currentPage + 1,
      );
      this.model.friends.addAll(result.data);

      this.model.update(
            friends: this.model.friends,
            currentPage: this.model.currentPage + 1,
            isLastPage: result.isLastPage,
          );
    } catch (e) {
      sendEvent(FriendPageEvent(
          action: FriendPageEventAction.error, message: e.toString()));
    }
  }

  Future _reloadFriends() async {
    try {
      final result = await getService<UserService>().getFriendsV2(
        type: this.model.filter,
        orderBy: this.model.sort,
        page: 1,
      );
      this.model.update(
            friends: result.data,
            currentPage: 1,
            isLastPage: result.isLastPage,
          );
    } catch (e) {
      sendEvent(FriendPageEvent(
          action: FriendPageEventAction.error, message: e.toString()));
    }
  }
}
