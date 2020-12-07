part of 'index.dart';

class SystemService extends MomentumService {
  Future<List<Hobby>> getAllHobbies() async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.hobbiesQuery();
    final hobies = (data as List)
        .map((e) => Mapper.fromJson(e).toObject<Hobby>())
        .toList();
    return hobies;
  }

  Future<String> getAddress(
      {@required String latitude, @required String longitude}) async {
    final graphql = getService<GraphqlService>();
    final address = await graphql.getAddressQuery(latitude, longitude);
    return address;
  }

  Future<List<ColorOfAnswer>> getColorsOfAnswer() async {
    final graphql = getService<GraphqlService>();
    final json = await graphql.colorsOfAnswerQuery();
    final result = (json as List)
        .map((e) => Mapper.fromJson(e).toObject<ColorOfAnswer>())
        .toList();
    return result;
  }

  Future<WithIsLastPageOutput<Question>> getQuestions({
    String keyword,
    int page,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.questionsQuery(keyword, page);
    final result = WithIsLastPageOutput<Question>.fromJson(data);
    return result;
  }
}
