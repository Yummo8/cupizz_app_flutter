part of '../index.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;

  const LoadingIndicator({
    Key key,
    this.size = 50,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitPumpingHeart(
      size: size,
      color: color ?? context.colorScheme.primary,
    );
  }
}
