import 'package:cupizz_app/src/base/base.dart';

class PostService extends MomentumService {
  Future<List<PostCategory>> getPostCategories({int page}) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.postCategoriesQuery();
    final result = (data as List ?? [])
        .map((e) => Mapper.fromJson(e).toObject<PostCategory>())
        .toList();
    return result;
  }

  Future<List<Post>> getPosts({int page, String categoryId}) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.postsQuery(page: page, categoryId: categoryId);
    final result = ((data as List) ?? [])
        .map<Post>((e) => Mapper.fromJson(e).toObject<Post>())
        .toList();
    return result;
  }
}
