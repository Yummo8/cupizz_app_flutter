import 'package:cupizz_app/src/base/base.dart';

class SmallAnimButton extends StatelessWidget {
  const SmallAnimButton({
    Key key,
    @required this.text,
    this.onPressed,
    this.height,
    this.width,
  }) : super(key: key);

  final String text;
  final Future Function() onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (40.0),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.onPrimary,
            context.colorScheme.onPrimary.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: context.colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 20,
          ),
        ],
        border: Border.all(
          width: 2,
          color: context.colorScheme.primaryVariant,
        ),
        borderRadius: BorderRadius.all(Radius.circular((22.0))),
      ),
      child: ArgonButton(
        height: height ?? 40,
        width: width ?? 100,
        borderRadius: 22.0,
        roundLoadingShape: false,
        color: Colors.transparent,
        child: Text(
          text,
          style: TextStyle(
              color: context.colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        loader: Center(
          child: LoadingIndicator(
            color: context.colorScheme.primaryVariant,
            size: 30,
          ),
        ),
        onTap: (startLoading, stopLoading, btnState) async {
          startLoading();
          try {
            if (onPressed != null) await onPressed();
          } finally {
            stopLoading();
          }
        },
      ),
    );
  }
}
