import 'package:cupizz_app/src/base/base.dart';

class AnswerGradient extends LinearGradient {
  AnswerGradient(List<Color> colors)
      : super(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
}
