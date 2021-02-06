import 'package:cupizz_app/src/base/base.dart';

import 'post_page.model.dart';

class PostPageController extends MomentumController<PostPageModel> {
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

  Future selectCategory(PostCategory category) async {
    if (category?.id == model.selectedCategory?.id) return;
    model.update(selectedCategory: category);
    await _loading(_reload);
  }

  Future _reload([int page = 1]) async {
    await trycatch(() async {
      final data = await getService<PostService>().getPosts(
        page: 1,
        categoryId: model.selectedCategory?.id,
      );
      model.update(
        posts: data,
        currentPage: 1,
        isLastPage: !data.isExistAndNotEmpty,
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
