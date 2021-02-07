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

  Future<WithIsLastPageOutput<Post>> getPosts({
    int page,
    String categoryId,
    String keyword,
    bool isMyPost,
  }) async {
    final graphql = getService<GraphqlService>();
    final data = await graphql.postsQuery(
      page: page,
      categoryId: categoryId,
      keyword: keyword,
      isMyPost: isMyPost,
    );
    final result = WithIsLastPageOutput<Post>.fromJson(data);
    return result;
  }

  Future<Post> likePost(int postId, {LikeType type}) async {
    final graphql = getService<GraphqlService>();
    final json = await graphql.likePostMutation(postId, type: type);
    return Mapper.fromJson(json).toObject<Post>();
  }

  Future<Post> unlikePost(int postId) async {
    final graphql = getService<GraphqlService>();
    final json = await graphql.unlikePostMutation(postId);
    return Mapper.fromJson(json).toObject<Post>();
  }
}
