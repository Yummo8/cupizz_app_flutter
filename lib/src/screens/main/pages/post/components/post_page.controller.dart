import 'package:cupizz_app/src/base/base.dart';

import 'post_page.model.dart';

const kIsMyPost = 'MY_POST';

class PostPageController extends MomentumController<PostPageModel> {
  final Debouncer _searchDebouncer = Debouncer(delay: 1.seconds);

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
