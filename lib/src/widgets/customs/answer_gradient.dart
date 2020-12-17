part of '../index.dart';

class AnswerGradient extends LinearGradient {
  AnswerGradient(List<Color> colors)
      : super(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
}
