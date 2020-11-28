part of '../index.dart';

const _SPACING = 3.0;

class GroupImage extends StatelessWidget {
  final List<FileModel> images;
  final BorderRadius borderRadius;
  final Function onPressed;

  const GroupImage({Key key, this.images, this.borderRadius, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ??
          () {
            PhotoViewDialog(
              context,
              images: images,
            ).show();
          },
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    } else if (images.length == 1) {
      return _buildImage(images[0]);
    } else if (images.length == 2) {
      return _build2Images();
    } else {
      return _buildMoreImages(context);
    }
  }

  Widget _build2Images() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 3, child: _buildImage(images[0])),
          const SizedBox(width: _SPACING),
          Expanded(flex: 2, child: _buildImage(images[1])),
        ],
      ),
    );
  }

  Widget _buildMoreImages(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 3, child: _buildImage(images[0])),
          const SizedBox(width: _SPACING),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: _buildImage(images[1]),
                  ),
                  const SizedBox(height: _SPACING),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: _buildImage(images[2]),
                        ),
                        if (images.length > 3)
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius:
                                  borderRadius ?? BorderRadius.circular(6),
                              child: Container(
                                color: Color.fromRGBO(0, 0, 0, 0.35),
                                child: Center(
                                    child: Text(
                                  '+${images.length - 3}',
                                  style: context.textTheme.headline2
                                      .copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildImage(FileModel image) {
    return Hero(
      tag: image?.url,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          child:
              CachedNetworkImage(imageUrl: image.thumbnail, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
