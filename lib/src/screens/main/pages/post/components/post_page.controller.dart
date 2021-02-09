import 'package:cupizz_app/src/base/base.dart';

import 'post_page.model.dart';

const kIsMyPost = 'MY_POST';

class PostPageController extends MomentumController<PostPageModel> {
  final Debouncer _searchDebouncer = Debouncer(delay: 1.seconds);
  final Debouncer _likeDebouncer = Debouncer(delay: 1.seconds);

  @override
  PostPageModel init() {
    return PostPageModel(
      this,
    );
  }

  @override
  Future bootstrapAsync() async {
    await _loading(_reload, enableLoading: !model.posts.isExistAndNotEmpty);
  }

  Future refresh() => _reload();

  Future loadMore() async {
    if (model.isLastPage) return;
    await _reload(model.currentPage + 1);
  }

  Future selectCategory(PostCategory category) async {
    if (category?.id == model.selectedCategory?.id) return;
    if (category?.id == kIsMyPost) {
      model.update(isMyPost: !model.isMyPost);
    } else {
      model.update(selectedCategory: category);
    }
    await _loading(_reload);
  }

  void search(String keyword) {
    if (keyword != model.keyword) {
      _searchDebouncer.debounce(() {
        _search(keyword);
      });
    }
  }

  Future clearSearch() => _search('');

  void changeIsIncognitoComment() {
    model.update(isIncognitoComment: !model.isIncognitoComment);
  }

  Future commentPost(Post post, String content) async {
    final index = model.posts.indexWhere((e) => e.id == post.id);
    await trycatch(() async {
      final comment = await getService<PostService>()
          .commentPost(post.id, content, isIncognito: model.isIncognitoComment);
      model.posts[index].comments.insert(0, comment);
      model.posts[index].commentCount++;
      model.update(posts: model.posts);
    });
  }

  Future loadmoreComments(Post post) async {
    if (post.commentCount <= post.comments?.length) return;
    final index = model.posts.indexWhere((e) => e.id == post.id);
    await trycatch(() async {
      final lastComment = post.comments.last;
      final comments = await getService<PostService>()
          .getComments(post.id, commentCursorId: lastComment.id);
      model.posts[index].comments.addAll(comments);
      model.update(posts: model.posts);
    });
  }

  Future likePost(Post post, [LikeType type]) async {
    final index = model.posts.indexWhere((e) => e.id == post.id);
    final oldLikeType = post.myLikedPostType;
    if (index >= 0) {
      model.posts[index].myLikedPostType = type ?? LikeType.love;
      model.posts[index].likeCount++;
    }
    model.update(posts: model.posts);

    _likeDebouncer.debounce(() async {
      try {
        // final data =
        await getService<PostService>().likePost(post.id, type: type);
        // model.posts[index] = data;
        // model.update(posts: model.posts);
      } catch (e) {
        if (index >= 0) {
          model.posts[index].myLikedPostType = oldLikeType;
          model.posts[index].likeCount--;
        }
        model.update(posts: model.posts);
        await Fluttertoast.showToast(msg: e.toString());
        rethrow;
      }
    });
  }

  Future unlikePost(Post post) async {
    final index = model.posts.indexWhere((e) => e.id == post.id);
    final oldLikeType = post.myLikedPostType;
    if (index >= 0) {
      model.posts[index].myLikedPostType = null;
      model.posts[index].likeCount--;
    }
    model.update(posts: model.posts);

    _likeDebouncer.debounce(() async {
      try {
        // final data =
        await getService<PostService>().unlikePost(post.id);
        // model.posts[index] = data;
        // model.update(posts: model.posts);
      } catch (e) {
        if (index >= 0) {
          model.posts[index].myLikedPostType = oldLikeType;
          model.posts[index].likeCount++;
        }
        model.update(posts: model.posts);
        await Fluttertoast.showToast(msg: e.toString());
        rethrow;
      }
    });
  }

  void insertPost(Post post) {
    final index = model.posts.indexWhere((e) => e.id == post.id);
    if (index > 0) return;
    model.posts.insert(0, post);
    model.update(posts: model.posts);
  }

  Future _search(String keyword) async {
    model.update(keyword: keyword);
    await _loading(_reload);
  }

  Future _reload([int page = 1]) async {
    await trycatch(() async {
      final posts = await getService<PostService>().getPosts(
        page: page,
        categoryId: model.selectedCategory?.id,
        keyword: model.keyword,
        isMyPost: model.isMyPost,
      );
      model.update(
        posts: page == 1 ? posts.data : [...model.posts, ...posts.data],
        currentPage: page,
        isLastPage: posts.isLastPage,
      );
    });
  }

  Future _loading(Function func,
      {bool throwError = false, bool enableLoading = true}) async {
    if (enableLoading) {
      model.update(isLoading: true);
    }
    try {
      await func();
    } catch (e) {
      unawaited(Fluttertoast.showToast(msg: e.toString()));
      if (throwError) rethrow;
    } finally {
      if (enableLoading) {
        model.update(isLoading: false);
      }
    }
  }
}
