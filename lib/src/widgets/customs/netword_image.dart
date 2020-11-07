part of '../index.dart';

class NetwordImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final bool isAvatar;

  const NetwordImage(
    this.url, {
    Key key,
    this.fit = BoxFit.cover,
    this.isAvatar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      progressIndicatorBuilder: (ctx, url, process) {
        return Center(
          child: CircularProgressIndicator(
            value: process.progress,
            valueColor: AlwaysStoppedAnimation(context.colorScheme.primary),
          ),
        );
      },
    );
  }
}
