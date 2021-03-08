import 'package:cupizz_app/src/base/base.dart';
import 'package:simple_animations/simple_animations.dart';

class LinearGradientAnimatedContainer extends StatelessWidget {
  final LinearGradient gradient;
  final Widget child;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final Decoration foregroundDecoration;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry margin;
  final Matrix4 transform;
  final AlignmentGeometry transformAlignment;
  final Clip clipBehavior;

  LinearGradientAnimatedContainer({
    Key key,
    this.gradient = const LinearGradient(colors: []),
    this.alignment,
    this.padding,
    this.foregroundDecoration,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
    double width,
    double height,
    BoxConstraints constraints,
  })  : constraints = (width != null || height != null)
            ? constraints?.tighten(width: width, height: height) ??
                BoxConstraints.tightFor(width: width, height: height)
            : constraints,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<int>();
    for (var i = 0; i < gradient.colors.length; i++) {
      tween.add(
        i,
        gradient.colors[i]
            .tweenTo(gradient.colors[gradient.colors.length - i - 1]),
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
            alignment: alignment,
            padding: padding,
            foregroundDecoration: foregroundDecoration,
            margin: margin,
            transform: transform,
            transformAlignment: transformAlignment,
            clipBehavior: clipBehavior,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: colors,
              begin: gradient.begin,
              end: gradient.end,
              stops: gradient.stops,
              tileMode: gradient.tileMode,
              transform: gradient.transform,
            )),
            child: child,
          );
        });
  }
}
