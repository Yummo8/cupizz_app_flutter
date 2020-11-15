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
}
