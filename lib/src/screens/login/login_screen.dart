import 'dart:math';

import 'package:cubizz_app/src/assets.dart';
import 'package:cubizz_app/src/widgets/customs/text_field.dart';
import 'package:cubizz_app/src/widgets/widgets.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import './widgets/animation_build_login.dart';
import '../../base/base.dart';
import 'widgets/auth_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double width = 190.0;
  double widthIcon = 200.0;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FlareControls controls = FlareControls();

  _getDisposeController() {
    email.clear();
    password.clear();
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PrimaryScaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(),
                height: size.height,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      context.colorScheme.primaryVariant.withOpacity(0.7),
                      context.colorScheme.primary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutQuad,
//                top: keyboardOpen ? -size.height / 3.2 : 0.0,
                child: AnimationBuildLogin(
                  size: size,
                  yOffset: size.height / 1.36,
                  color: context.colorScheme.background,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    final name = 'Heart${Random().nextInt(2) + 1}';
                    controls.play(name);
                  },
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: FlareActor(
                      Assets.flares.logo,
                      fit: BoxFit.cover,
                      animation: "Cloud",
                      controller: controls,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome Back !',
                      style: TextStyle(
                        color: context.colorScheme.background,
                        fontSize: 24.0,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 22,
                  left: 22,
                  bottom: 22,
                  top: 270,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TextFieldWidget(
                        hintText: 'Email',
                        obscureText: false,
                        prefixIconData: Icons.mail_outline,
                        textEditingController: email,
                        focusNode: emailFocus,
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Container(
                      child: TextFieldWidget(
                        hintText: 'Password',
                        obscureText: true,
                        prefixIconData: Icons.lock,
                        textEditingController: password,
                        focusNode: passwordFocus,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8, top: 18),
                      child: Text(
                        "Forget Password ?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 18,
                          color: context.colorScheme.onPrimary.withOpacity(0.9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      margin: EdgeInsets.only(
                        top: 40,
                        right: (8),
                        left: (8),
                        bottom: (20),
                      ),
                      child: AuthButton(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: context.colorScheme.background,
        height: 70,
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AnimatedContainer(
                  width: widthIcon,
                  duration: Duration(seconds: 1),
                  curve: Curves.linear,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildSocialButton(
                        Assets.icons.google,
                        margin: EdgeInsets.only(left: 30.0),
                      ),
                      _buildSocialButton(
                        Assets.icons.facebook,
                        margin: EdgeInsets.only(right: 30.0),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _getDisposeController();
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 800),
                        child: Container(),
                      ),
                    ).then((value) {
                      Future.delayed(Duration(milliseconds: 300), () {
                        setState(() {
                          width = 190;
                          widthIcon = 200;
                        });
                      });
                    });
                    setState(() {
                      width = 400.0;
                      widthIcon = 0;
                    });
                  },
                  child: AnimatedContainer(
                    height: 65.0,
                    width: width,
                    duration: Duration(milliseconds: 1000),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Icon(Icons.arrow_back_ios,
                              color: context.colorScheme.onPrimary),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                                child: Text(
                                  "Not Yet Register ?",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    color: context.colorScheme.onPrimary
                                        .withOpacity(0.9),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                                child: Text(
                                  "Sign Up",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    color: context.colorScheme.onPrimary
                                        .withOpacity(0.9),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    curve: Curves.linear,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                      color: context.colorScheme.primaryVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String imageName, {EdgeInsetsGeometry margin}) {
    return Container(
//    margin: EdgeInsets.only(left: 35.0),
      margin: margin,
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Image.asset(
          imageName,
          height: 28,
          width: 28,
        ),
      ),
    );
  }
}
