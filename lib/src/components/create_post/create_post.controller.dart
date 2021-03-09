import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/screens/main/pages/post/components/post_page.controller.dart';

import 'create_post.model.dart';

class CreatePostController extends MomentumController<CreatePostModel> {
  @override
  CreatePostModel init() {
    return CreatePostModel(
      this,
    );
  }

  void pickImages(List<File> images) {
    if (images.length + model!.images.length > Constants.maxPostImage) {
      Fluttertoast.showToast(
          msg: 'Bạn được gửi tối đa ${Constants.maxPostImage} ảnh.');
      return;
    }
    model!.images.addAll(images);
    model!.update(images: model!.images);
  }

  void deleteImage(File image) {
    model!.images.removeWhere((e) => e.path == image.path);
    model!.update(images: model!.images);
  }

  void selectCategory(PostCategory? category) {
    model!.update(selected: category);
  }

  void onChangedContent(String content) {
    model!.update(content: content);
  }

  Future createPost() async {
    if (model!.selected == null) {
      await Fluttertoast.showToast(msg: 'Hãy chọn danh mục mà bạn muốn đăng');
      return;
    }
    await trycatch(() async {
      final post = await Get.find<PostService>()
          .createPost(model!.selected!.id, model!.content, model!.images);
      dependOn<PostPageController>().insertPost(post);
      reset();
    });
  }
}
