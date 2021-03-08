part of 'create_post_widgets.dart';

class _CreatePostImage extends StatelessWidget {
  final File? image;
  final Function? onCrossIconPressed;
  const _CreatePostImage({Key? key, this.image, this.onCrossIconPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image == null
        ? const SizedBox.shrink()
        : Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  image!,
                  height: 220,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: onCrossIconPressed as void Function()?,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
