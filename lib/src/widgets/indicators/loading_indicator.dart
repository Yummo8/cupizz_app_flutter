import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final EdgeInsets padding;

  const LoadingIndicator({
    Key key,
    this.size = 50,
    this.color,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SpinKitPumpingHeart(
        size: size,
        color: color ?? context.colorScheme.primary,
      ),
    );
  }
}
