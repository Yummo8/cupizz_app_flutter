import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cupizz_app/src/base/base.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarGlow(
              endRadius: 60.0,
              glowColor: indigoPinkLight.primaryColor,
              duration: Duration(milliseconds: 1000),
              repeatPauseDuration: Duration(milliseconds: 100),
              child: LoadingIndicator(
                color: indigoPinkLight.colorScheme.primaryVariant,
              ),
            ),
            SizedBox(
              width: 250.0,
              child: ColorizeAnimatedTextKit(
                text: [
                  'Cupizz',
                  'Loading...',
                ],
                repeatForever: true,
                textStyle: GoogleFonts.pacifico(
                  fontSize: 30.0,
                  color: indigoPinkLight.primaryColor,
                ),
                colors: [
                  indigoPinkLight.primaryColor,
                  Colors.purple,
                  Colors.blue,
                  Colors.yellow,
                  Colors.red,
                ],
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
