part of '../index.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    Key key,
    @required this.controls,
  }) : super(key: key);

  final FlareControls controls;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
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
              animation: 'Cloud',
              controller: controls,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -60),
          child: Text(
            'Cupizz',
            style: GoogleFonts.pacifico(
              fontSize: 43.0,
              color: context.colorScheme.background,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotateAnimatedTextKit(
                text: [
                  'giao lưu',
                  'kết bạn',
                  'gặp gỡ',
                  'hẹn hò',
                  'và hơn thế nữa!'
                ],
                textStyle: GoogleFonts.srisakdi(
                  fontSize: 35.0,
                  color: context.colorScheme.background,
                ),
                textAlign: TextAlign.center,
                pause: Duration(seconds: 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
