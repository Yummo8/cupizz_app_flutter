part of '../index.dart';

class OtpDialog {
  static Future show(BuildContext context,
      {Future Function(String otp) onSubmit,
      String email,
      Function resend}) async {
    var onTapRecognizer = TapGestureRecognizer()..onTap = resend;
    var textEditingController = TextEditingController();
    StreamController<ErrorAnimationType> errorController;
    var hasError = false;
    var currentText = '';

    final formKey = GlobalKey<FormState>();
    await showCupertinoDialog(
        context: context,
        builder: (_) => Dialog(
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  itemExtent: null,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: FlareActor(
                        Assets.i.flares.otp,
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8),
                      child: RichText(
                        text: TextSpan(
                            text: 'Nhập mã xác thực đã được gửi tới email ',
                            children: [
                              if (email.isExistAndNotEmpty)
                                TextSpan(
                                    text: email,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                            ],
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15)),
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
                              fieldHeight: 40,
                              fieldWidth: 35,
                              selectedFillColor:
                                  context.colorScheme.primaryVariant,
                              activeColor: context.colorScheme.primary,
                              activeFillColor: hasError
                                  ? Colors.transparent
                                  : context.colorScheme.background,
                            ),
                            cursorColor: context.colorScheme.onBackground,
                            animationDuration: Duration(milliseconds: 300),
                            textStyle: context.textTheme.headline6
                                .copyWith(height: 1.6),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              print(value);
                              currentText = value;
                            },
                          )),
                    ),
                    if (hasError)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          '*Hãy điền đủ 6 số',
                          style: context.textTheme.bodyText1.copyWith(
                              color: context.colorScheme.error,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    const SizedBox(height: 20),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Không nhận được mã xác thực? ',
                          style: context.textTheme.bodyText1,
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
                    Align(
                      child: SmallAnimButton(
                        text: 'Xác thực',
                        onPressed: () async {
                          if (onSubmit != null) {
                            await onSubmit(currentText);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ));
  }
}
