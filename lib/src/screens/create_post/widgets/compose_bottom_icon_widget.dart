part of 'create_post_widgets.dart';

class ComposeBottomIconWidget extends StatelessWidget {
  final Function(List<File>) onImageIconSelected;

  ComposeBottomIconWidget({Key key, this.onImageIconSelected})
      : super(key: key);

  void _pickImage(BuildContext context, int maxSelected) {
    pickImage(
      context,
      (files) {
        onImageIconSelected?.call(files);
      },
      maxSelected: maxSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [CreatePostController],
        builder: (context, snapshot) {
          final model = snapshot<CreatePostModel>();
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Theme.of(context).dividerColor)),
                color: context.colorScheme.background),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: model.images.length >= Constants.maxPostImage
                      ? null
                      : () => _pickImage(context,
                          Constants.maxPostImage - model.images.length),
                  icon: Icon(
                    CupertinoIcons.photo_on_rectangle,
                    color: context.colorScheme.primary,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Bài viết này sẽ được đảm bảo không để lộ danh tính',
                    textAlign: TextAlign.right,
                    style: context.textTheme.caption
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                ))
              ],
            ),
          );
        });
  }
}
