import 'dart:math';

import 'package:cubizz_app/src/components/theme/theme.controller.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import '../../../base/base.dart';

class AuthButton extends StatefulWidget {
  @override
  _AuthButtonState createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> with TickerProviderStateMixin {
  String _buttonText = 'BUY TICKET';

  AnimationController _controller;
  Animation _roundnessAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    )..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Container();
          }),
        );
      }
    });

    _roundnessAnimation = Tween(begin: 10.0, end: 25.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Momentum.controller<ThemeController>(context).randomTheme();
          // setState(() {
          //   _controller.forward();
          // });
        },
        child: Hero(
          tag: 'blackBox',
          flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) {
            return Container(
              decoration: BoxDecoration(
                color: context.colorScheme.primaryVariant,
                shape: BoxShape.circle,
              ),
            );
          },
          child: Container(
            height: (60.0),
            decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    context.colorScheme.onPrimary,
                    context.colorScheme.onPrimary.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.primary.withOpacity(0.6),
                    spreadRadius: 5,
                    blurRadius: 20,
                    // changes position of shadow
                  ),
                ],
                border: Border.all(
                  width: 2,
                  color: context.colorScheme
                      .primaryVariant, //                   <--- border width here
                ),
                color: context.colorScheme.onPrimary,
                borderRadius: BorderRadius.all(Radius.circular((22.0)))),
            child: Container(
//                        margin: EdgeInsets.only(left: (10)),
              alignment: Alignment.center,
              child: Text(
                "SIGN IN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1,
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
