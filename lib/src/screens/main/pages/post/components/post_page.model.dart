import 'package:cupizz_app/src/base/base.dart';

import 'post_page.controller.dart';

class PostPageModel extends MomentumModel<PostPageController> {
  PostPageModel(
    PostPageController controller, {
    this.posts,
    this.isLastPage,
    this.categories,
  }) : super(controller);

  final List<Post> posts;
  final bool isLastPage;
  final List<PostCategory> categories;

  @override
  void update() {
    PostPageModel(
      controller,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return PostPageModel(controller);
  }

  @override
  Map<String, dynamic> toJson() => {};
}
