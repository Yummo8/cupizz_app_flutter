part of '../index.dart';

class AuthButton extends StatelessWidget {
  final Future Function() onPressed;
  final String text;

  const AuthButton({Key key, this.onPressed, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Hero(
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
                height: 60,
                width: 350,
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
                  if (onPressed != null) await onPressed();
                  stopLoading();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
