part of '../index.dart';

class PhotoViewDescription {
  final String title;
  final String subTitle;
  final String content;

  PhotoViewDescription({this.title, this.subTitle, this.content});
}

class PhotoViewDialog {
  final BuildContext context;
  final List<FileModel> images;
  final List<PhotoViewDescription> descriptions;

  PhotoViewDialog(
    this.context, {
    @required this.images,
    this.descriptions,
  });

  Future show() {
    return showDialog(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return _PhotoView(images: images, descriptions: descriptions);
        });
  }
}

class _PhotoView extends StatefulWidget {
  final List<FileModel> images;
  final List<PhotoViewDescription> descriptions;

  const _PhotoView({Key key, this.images = const [], this.descriptions})
      : assert(descriptions == null || descriptions.length == images.length,
            'Mảng images và mảng description phải có cùng độ dài'),
        super(key: key);

  @override
  __PhotoViewState createState() => __PhotoViewState();
}

class __PhotoViewState extends State<_PhotoView> {
  int currentPage = 0;

  _onBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBack(context),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: <Widget>[
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: widget.images.length,
            onPageChanged: (i) {
              setState(() {
                currentPage = i;
              });
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    CachedNetworkImageProvider(widget.images[index].url),
                minScale: PhotoViewComputedScale.contained * 1,
                maxScale: PhotoViewComputedScale.contained * 5,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.images[index].url),
              );
            },
            loadingBuilder: (context, event) {
              return LoadingIndicator();
            },
          ),
          if (widget.descriptions != null)
            Positioned(
              left: 10,
              bottom: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (widget.descriptions[currentPage].title != null)
                      Text(
                        widget.descriptions[currentPage].title ?? '',
                        style: context.textTheme.subtitle1.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    if (widget.descriptions[currentPage].subTitle != null)
                      Text(
                        widget.descriptions[currentPage].subTitle ?? '',
                        style: context.textTheme.caption
                            .copyWith(color: Colors.white70),
                      ),
                    const SizedBox(height: 4),
                    if (widget.descriptions[currentPage].content != null)
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.6,
                        ),
                        child: SingleChildScrollView(
                          child: HiddenText(
                            (widget.descriptions[currentPage].content ?? '')
                                .replaceAll('\\n', '\n'),
                            maxLength: 200,
                            duration: 300,
                            readmoreText: '',
                            style: context.textTheme.bodyText2
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          Positioned(
            top: 12,
            left: 14,
            right: 14,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    pressedOpacity: 0.7,
                    padding: EdgeInsets.all(0),
                    onPressed: () => _onBack(context),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  if (widget.images.length > 1)
                    Text('${currentPage + 1} / ${widget.images.length}',
                        style: context.textTheme.caption
                            .copyWith(color: Colors.white))
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
