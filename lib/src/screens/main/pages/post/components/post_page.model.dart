import 'package:cupizz_app/src/base/base.dart';

import 'post_page.controller.dart';

class PostPageModel extends MomentumModel<PostPageController> {
  PostPageModel(
    PostPageController controller, {
    this.posts,
    this.isLastPage,
    this.selectedCategories,
  }) : super(controller);

  final List<Post> posts;
  final bool isLastPage;
  final PostCategory selectedCategories;

  @override
  void update({
    List<Post> posts,
    bool isLastPage,
    PostCategory selectedCategories,
  }) {
    PostPageModel(
      controller,
      posts: posts ?? this.posts,
      isLastPage: isLastPage ?? this.isLastPage,
      selectedCategories: selectedCategories ?? this.selectedCategories,
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
      selectedCategories: json['selectedCategories'] != null
          ? Mapper.fromJson(json['selectedCategories']).toObject<PostCategory>()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {};
}
