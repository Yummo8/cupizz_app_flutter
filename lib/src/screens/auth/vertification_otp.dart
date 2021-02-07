import 'dart:async';

import '../../base/base.dart';
import 'package:cupizz_app/src/assets.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationOtpScreen extends StatefulWidget {
  VerificationOtpScreen();

  @override
  _VerificationOtpScreenState createState() => _VerificationOtpScreenState();
}

class _VerificationOtpScreenState extends State<VerificationOtpScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = '';
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FlareActor(
                  Assets.flares.otp,
                  animation: 'otp',
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Xác thực email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: 'Nhập mã xác thực đã được gửi tới email ',
                      children: [
                        TextSpan(
                            text: Momentum.controller<AuthController>(context)
                                .model
                                .email,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: context.colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      autovalidateMode: AutovalidateMode.disabled,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length != 6) {
                          return 'Vui lòng nhập mã xác thực';
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 60,
                        fieldWidth: 50,
                        selectedFillColor: context.colorScheme.primaryVariant,
                        activeColor: context.colorScheme.primary,
                        activeFillColor: hasError
                            ? context.colorScheme.error
                            : context.colorScheme.background,
                      ),
                      cursorColor: context.colorScheme.onBackground,
                      animationDuration: Duration(milliseconds: 300),
                      textStyle:
                          context.textTheme.headline6.copyWith(height: 1.6),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? '*Hãy điền đủ 6 số' : '',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Không nhận được mã xác thực? ',
                    style: context.textTheme.subtitle1,
                    children: [
                      TextSpan(
                          text: ' GỬI LẠI',
                          recognizer: onTapRecognizer,
                          style: context.textTheme.subtitle1.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ))
                    ]),
              ),
              const SizedBox(height: 30),
              AuthButton(
                text: 'Xác thực',
                onPressed: () async {
                  await Momentum.controller<AuthController>(context)
                      .vertifyOtp(textEditingController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
