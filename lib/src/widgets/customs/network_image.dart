part of '../index.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final bool isAvatar;
  final BorderRadius borderRadius;

  const CustomNetworkImage(
    this.url, {
    Key key,
    this.fit = BoxFit.cover,
    this.isAvatar = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isAvatar && borderRadius == null
          ? BorderRadius.circular(90)
          : borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
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
      ),
    );
  }
}
