import 'dart:math';

import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_animations/simple_animations.dart';

enum SuperLikeAniProps { opacity, scale }

class SuperLikeOverlay extends StatelessWidget {
  final BorderRadius? borderRadius;

  const SuperLikeOverlay({Key? key, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<SuperLikeAniProps>()
      ..add(SuperLikeAniProps.opacity, 0.0.tweenTo(1.0), 200.milliseconds)
      ..add(SuperLikeAniProps.scale, 1.5.tweenTo(1.0), 500.milliseconds,
          Curves.easeOutCirc);

    return PlayAnimation<MultiTweenValues<SuperLikeAniProps>>(
      tween: _tween,
      duration: _tween.duration,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.yellow
                .withOpacity(value.get(SuperLikeAniProps.opacity) * 0.5),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 50, left: 30),
              child: Transform.scale(
                scale: value.get(SuperLikeAniProps.scale),
                child: Opacity(
                  opacity: value.get(SuperLikeAniProps.opacity),
                  child: Transform.rotate(
                    angle: -pi / 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.yellow,
                            width: 5,
                            style: BorderStyle.solid),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.icons.star,
                            height: 50,
                            width: 50,
                          ),
                          const Text(
                            'Super Like',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
