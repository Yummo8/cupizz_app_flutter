part of '../friend_page_v2.dart';

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
  Future<void> bootstrapAsync() => _reloadFriends();

  Future refresh() async {
    await _reloadFriends();
    model.animationController?.fling();
  }

  Future _reloadFriends() async {
    try {
      final service = getService<UserService>();

      final result = await Future.wait([
        service.getFriendsV2(
          type: FriendQueryType.all,
          orderBy: model.allFriends.sort,
          page: 1,
        ),
        service.getFriendsV2(
          type: FriendQueryType.received,
          orderBy: model.allFriends.sort,
          page: 1,
        ),
      ]);

      model.update(
        allFriends: model.allFriends.copyWith(
            currentPage: 1,
            friends: result[0].data,
            isLastPage: result[0].isLastPage),
        receivedFriends: model.receivedFriends.copyWith(
            currentPage: 1,
            friends: result[0].data,
            isLastPage: result[0].isLastPage),
      );
    } catch (e) {
      sendEvent(FriendPageEvent(
          action: FriendPageEventAction.error, message: e.toString()));
    }
  }
}
