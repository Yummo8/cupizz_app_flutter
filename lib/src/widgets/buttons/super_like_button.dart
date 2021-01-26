import 'dart:math';

import 'package:cupizz_app/src/base/base.dart';
import 'package:simple_animations/simple_animations.dart';

class SuperLikeButton extends StatefulWidget {
  final Function onPressed;

  const SuperLikeButton({Key key, this.onPressed}) : super(key: key);

  @override
  _SuperLikeButtonState createState() => _SuperLikeButtonState();
}

class _SuperLikeButtonState extends State<SuperLikeButton> {
  CustomAnimationControl control = CustomAnimationControl.STOP;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<DefaultAnimationProperties>()
      ..add(DefaultAnimationProperties.rotation, 0.0.tweenTo(pi / 6),
          200.milliseconds)
      ..add(
          DefaultAnimationProperties.scale, 1.0.tweenTo(1.5), 200.milliseconds);
    return CustomAnimation<MultiTweenValues<DefaultAnimationProperties>>(
      control: control,
      tween: tween,
      duration: tween.duration,
      builder: (context, child, value) {
        return GestureDetector(
          onTap: () async {
            if (control != CustomAnimationControl.STOP) return;
            control = CustomAnimationControl.PLAY_FROM_START;
            setState(() {});
            widget.onPressed?.call();
            await Future.delayed(
                (tween.duration.inMilliseconds + 200).milliseconds);
            control = CustomAnimationControl.PLAY_REVERSE_FROM_END;
            setState(() {});
            await Future.delayed(tween.duration);
            control = CustomAnimationControl.STOP;
            setState(() {});
          },
          child: Transform.rotate(
            angle: value.get(DefaultAnimationProperties.rotation),
            child: Transform.scale(
              scale: value.get(DefaultAnimationProperties.scale),
              child: AnimatedSwitcher(
                duration: 500.milliseconds,
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: Icon(
                  Icons.star,
                  color: context.colorScheme.primary,
                  size: 30,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
