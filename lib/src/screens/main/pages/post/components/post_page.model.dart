import 'package:cupizz_app/src/base/base.dart';

import 'post_page.controller.dart';

class PostPageModel extends MomentumModel<PostPageController> {
  PostPageModel(
    PostPageController controller, {
    this.posts,
    this.isLastPage,
    this.selectedCategory,
    this.currentPage,
    this.isLoading = false,
  }) : super(controller);

  final List<Post> posts;
  final bool isLastPage;
  final PostCategory selectedCategory;
  final int currentPage;

  final bool isLoading;

  @override
  void update({
    List<Post> posts,
    bool isLastPage,
    PostCategory selectedCategory,
    int currentPage,
    bool isLoading,
  }) {
    PostPageModel(
      controller,
      posts: posts ?? this.posts,
      isLastPage: isLastPage ?? this.isLastPage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading ?? false,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return PostPageModel(
      controller,
      isLastPage: json['isLastPage'] ?? false,
      posts: (json['posts'] as List)
              ?.map((e) => Mapper.fromJson(e).toObject<Post>())
              ?.toList() ??
          [],
      selectedCategory: json['selectedCategory'] != null
          ? Mapper.fromJson(json['selectedCategory']).toObject<PostCategory>()
          : null,
      currentPage: json['currentPage'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'posts': posts?.map((e) => e.toJson())?.toList() ?? [],
        'isLastPage': isLastPage,
        'selectedCategory': selectedCategory?.toJson(),
        'currentPage': currentPage ?? 1,
      };
}
