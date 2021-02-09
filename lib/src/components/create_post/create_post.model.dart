import 'package:cupizz_app/src/base/base.dart';

import 'create_post.controller.dart';

class CreatePostModel extends MomentumModel<CreatePostController> {
  CreatePostModel(
    CreatePostController controller, {
    this.selected,
    this.content,
    List<File> images,
  })  : images = images ?? [],
        super(controller);

  final PostCategory selected;
  final String content;
  final List<File> images;

  @override
  void update({
    PostCategory selected,
    String content,
    List<File> images,
  }) {
    CreatePostModel(
      controller,
      selected: selected ?? this.selected,
      content: content ?? this.content,
      images: images ?? this.images,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return CreatePostModel(
      controller,
      content: json['content'],
      selected: json['selected'] != null
          ? Mapper.fromJson(json['selected']).toObject<PostCategory>()
          : null,
      images: (json['images'] as List ?? []).map((e) => File(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'content': content,
        'selected': selected?.toJson(),
        'images': (images ?? []).map((e) => e.path).toList()
      };
}
