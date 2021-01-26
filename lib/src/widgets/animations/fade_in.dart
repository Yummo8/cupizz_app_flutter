import 'package:cupizz_app/src/base/base.dart';
import 'package:simple_animations/simple_animations.dart';

enum _AniProps { opacity, translateX }

class FadeInTranslate extends StatelessWidget {
  final double delay;
  final Widget child;
  final bool enabled;

  FadeInTranslate({this.delay = 0, @required this.child, this.enabled});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, 0.0.tweenTo(1.0), 500.milliseconds)
      ..add(_AniProps.translateX, 130.0.tweenTo(0.0), 500.milliseconds);

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => !enabled
          ? child
          : Opacity(
              opacity: value.get(_AniProps.opacity),
              child: Transform.translate(
                  offset: Offset(value.get(_AniProps.translateX), 0),
                  child: child),
            ),
    );
  }
}

class FadeIn extends StatelessWidget {
  final double delay;
  final Widget child;
  final int duration;

  FadeIn({this.delay = 0, @required this.child, this.duration = 500});

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: duration.milliseconds,
      tween: 0.0.tweenTo(1.0),
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value,
        child: child,
      ),
    );
  }
}
