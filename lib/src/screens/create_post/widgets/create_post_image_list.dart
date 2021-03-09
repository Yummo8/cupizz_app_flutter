part of 'create_post_widgets.dart';

class CreatePostImageList extends StatelessWidget {
  final List<File>? images;
  final Function(File)? onRemovedImage;
  const CreatePostImageList({
    Key? key,
    this.images,
    this.onRemovedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: (images ?? [])
            .mapIndexed(((e, i) => Padding(
                  padding: EdgeInsets.only(right: 10, left: i == 0 ? 10 : 0),
                  child: _CreatePostImage(
                    image: e,
                    onCrossIconPressed: () {
                      onRemovedImage?.call(images![i]);
                    },
                  ),
                )))
            .toList(),
      ),
    );
  }
}
