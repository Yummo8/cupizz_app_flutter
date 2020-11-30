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

  // @override
  // Future<void> bootstrapAsync() => _reloadFriends();

  Future refresh() async {
    model.animationController?.forward();
    await _reloadFriends();
  }

  Future updateSettings({
    FriendQueryType filter,
    FriendQueryOrderBy sort,
    bool isMultiColumn,
  }) async {
    if (filter != null || sort != null || isMultiColumn != null) {
      model.update(
        isLoading: true,
        filter: filter,
        sort: sort,
        isMultiColumn: isMultiColumn,
      );
      await _reloadFriends();
      model.update(isLoading: false);
      model.animationController?.reset();
      model.animationController?.forward();
    }
  }

  Future loadmoreFriends() async {
    if (model.isLastPage) return;
    try {
      final result = await getService<UserService>().getFriendsV2(
        type: model.filter,
        orderBy: model.sort,
        page: model.currentPage + 1,
      );
      model.friends.addAll(result.data);

      model.update(
        friends: model.friends,
        currentPage: model.currentPage + 1,
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
        type: model.filter,
        orderBy: model.sort,
        page: 1,
      );
      model.update(
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
