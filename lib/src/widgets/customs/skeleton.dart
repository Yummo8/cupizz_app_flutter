import 'package:cupizz_app/src/base/base.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final bool autoContainer;
  final Color? baseColor;
  final Color? highlightColor;

  const Skeleton(
      {Key? key,
      required this.child,
      this.enabled = true,
      this.autoContainer = false,
      this.baseColor,
      this.highlightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return enabled
        ? Shimmer.fromColors(
            baseColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900]!
                : Colors.grey[100]!,
            highlightColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!
                : Colors.grey[200]!,
            enabled: true,
            child: autoContainer
                ? Container(
                    color: context.colorScheme.background,
                    child: child,
                  )
                : child,
          )
        : child;
  }
}

class SkeletonItem extends StatelessWidget {
  const SkeletonItem(
      {Key? key, this.color, required this.child, this.width, this.height})
      : super(key: key);

  final Color? color;
  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? context.colorScheme.background,
      width: width,
      height: height,
      child: child,
    );
  }
}
