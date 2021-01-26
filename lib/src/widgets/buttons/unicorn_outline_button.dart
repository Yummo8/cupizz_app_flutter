import 'package:cupizz_app/src/base/base.dart';
import 'package:simple_animations/simple_animations.dart';

class UnicornOutlineButton extends StatelessWidget {
  UnicornOutlineButton({
    this.strokeWidth = 2,
    this.radius = 10,
    this.gradient = const LinearGradient(colors: []),
    @required this.child,
    this.onPressed,
    this.padding,
    this.borderRadius,
    this.isAnimated = false,
  });

  final double strokeWidth;
  final LinearGradient gradient;
  final Widget child;
  final VoidCallback onPressed;
  final double radius;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final bool isAnimated;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<int>();
    for (var i = 0; i < gradient.colors.length; i++) {
      tween.add(
        i,
        gradient.colors[i].tweenTo(
            gradient.colors[isAnimated ? gradient.colors.length - i - 1 : i]),
        3.seconds,
      );
    }

    return MirrorAnimation<MultiTweenValues<int>>(
      tween: tween,
      duration: tween.duration,
      builder: (context, _child, value) {
        final colors = List<Color>.generate(
            gradient.colors.length, (index) => value.get(index));
        return Container(
          width: context.width * 0.4,
          height: context.width * 0.4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: CustomPaint(
            painter: _GradientPainter(
              strokeWidth: strokeWidth,
              radius: radius,
              gradient: LinearGradient(
                colors: colors,
                begin: gradient.begin,
                end: gradient.end,
                stops: gradient.stops,
                tileMode: gradient.tileMode,
                transform: gradient.transform,
              ),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onPressed,
              child: InkWell(
                borderRadius: borderRadius ?? BorderRadius.circular(radius),
                onTap: onPressed,
                child: Container(
                  margin: const EdgeInsets.all(0.5),
                  padding: padding,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GradientPainter extends CustomPainter {
  _GradientPainter({
    @required double strokeWidth,
    @required double radius,
    Gradient gradient = const LinearGradient(colors: []),
  })  : _strokeWidth = strokeWidth,
        _radius = radius,
        _gradient = gradient;

  final Paint _paint = Paint();
  final double _radius;
  final double _strokeWidth;
  final Gradient _gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final outerRect = Offset.zero & size;
    final outerRRect = RRect.fromRectAndRadius(
      outerRect,
      Radius.circular(_radius),
    );

    final innerRect = Rect.fromLTWH(_strokeWidth, _strokeWidth,
        size.width - _strokeWidth * 2, size.height - _strokeWidth * 2);
    final innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(_radius - _strokeWidth));

    _paint.shader = _gradient.createShader(outerRect);

    final path1 = Path()..addRRect(outerRRect);
    final path2 = Path()..addRRect(innerRRect);
    final path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
