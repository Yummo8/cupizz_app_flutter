part of 'index.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  double width = 400.0;
  double widthIcon = 200.0;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FlareControls controls = FlareControls();
  final _formKey = GlobalKey<FormState>();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  var list = [
    Colors.lightGreen,
    Colors.redAccent,
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        width = 190.0;
      });
    });
  }

  void _backToLogin() {
    Navigator.pop(
      context,
      // ignore: missing_required_param
      PageTransition(
        type: PageTransitionType.leftToRight,
        duration: Duration(milliseconds: 800),
      ),
    );
    // Router.pop(
    //   context,
    //   transition: (ctx, widget) => PageTransition(
    //     type: PageTransitionType.leftToRight,
    //     duration: Duration(milliseconds: 800),
    //     child: Container(),
    //   ),
    // );
    setState(() {
      width = 500;
      widthIcon = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(),
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.colorScheme.primaryVariant.withOpacity(0.8),
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
                child: AnimationBuildLogin(
                  size: size,
                  yOffset: size.height / 1.26,
                  color: context.colorScheme.background,
                ),
              ),
              AuthHeader(controls: controls),
              Padding(
                padding: const EdgeInsets.only(
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
                        hintText: Strings.common.name,
                        obscureText: false,
                        prefixIconData: Icons.account_circle,
                        textEditingController: name,
                        validator: Validator.name,
                        onChanged: (v) {
                          Momentum.controller<AuthController>(context)
                              .model
                              .update(nickname: v);
                        },
                        focusNode: nameFocus,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFieldWidget(
                        hintText: Strings.common.email,
                        obscureText: false,
                        prefixIconData: Icons.email,
                        textEditingController: email,
                        validator: Validator.email,
                        focusNode: emailFocus,
                        onChanged: (v) {
                          Momentum.controller<AuthController>(context)
                              .model
                              .update(email: v);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFieldWidget(
                        hintText: Strings.common.password,
                        obscureText: true,
                        prefixIconData: Icons.lock,
                        focusNode: passwordFocus,
                        textEditingController: password,
                        validator: Validator.password,
                        onChanged: (v) {
                          Momentum.controller<AuthController>(context)
                              .model
                              .update(password: v);
                        },
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
                      child: AuthButton(
                        text: Strings.button.register,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await Momentum.controller<AuthController>(context)
                                .registerEmail();

                            await showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return VerificationOtpScreen();
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 30),
        color: context.colorScheme.background,
        height: 70,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: _backToLogin,
                  child: AnimatedContainer(
                    height: 65.0,
                    width: width,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.linear,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  Strings.register.haveAccount,
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
                                child: Text(
                                  Strings.register.loginNow,
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
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: context.colorScheme.primaryVariant),
                  ),
                ),
                AnimatedContainer(
                  width: widthIcon,
                  duration: Duration(seconds: 1),
                  curve: Curves.linear,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SocialButton(
                        imageName: Assets.i.icons.google,
                        margin: EdgeInsets.only(left: 30.0),
                        type: SocialProviderType.google,
                      ),
                      SocialButton(
                        imageName: Assets.i.icons.facebook,
                        margin: EdgeInsets.only(right: 30.0),
                        type: SocialProviderType.facebook,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
