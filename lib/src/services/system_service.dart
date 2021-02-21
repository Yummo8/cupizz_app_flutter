import 'package:cupizz_app/src/base/base.dart';

class SystemService extends GetxService {
  Future<List<Hobby>> getAllHobbies() async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.hobbiesQuery();
    final hobies = (data as List)
        .map((e) => Mapper.fromJson(e).toObject<Hobby>())
        .toList();
    return hobies;
  }

  Future<String> getAddress(
      {@required String latitude, @required String longitude}) async {
    final graphql = Get.find<GraphqlService>();
    final address = await graphql.getAddressQuery(latitude, longitude);
    return address;
  }

  Future<List<ColorOfAnswer>> getColorsOfAnswer() async {
    final graphql = Get.find<GraphqlService>();
    final json = await graphql.colorsOfAnswerQuery();
    final result = (json as List)
        .map((e) => Mapper.fromJson(e).toObject<ColorOfAnswer>())
        .toList();
    return result;
  }

  Future<int> getUnreadMessageCount() async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.unreadMessageCountQuery();
    return data;
  }

  Future<int> getUnreadReceiveFriendCount() async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.unreadReceiveFriendCountQuery();
    return data;
  }

  Future<int> getUnreadAcceptedFriendCount() async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.unreadAcceptedFriendCountQuery();
    return data;
  }

  Future<String> getAgoraAppId() async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.getAgoraAppIdQuery();
    return data;
  }

  Future<WithIsLastPageOutput<Question>> getQuestions({
    String keyword,
    int page,
  }) async {
    final graphql = Get.find<GraphqlService>();
    final data = await graphql.questionsQuery(keyword, page);
    final result = WithIsLastPageOutput<Question>.fromJson(data);
    return result;
  }
}
