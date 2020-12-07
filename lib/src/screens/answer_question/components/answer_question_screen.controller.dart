part of '../answer_question_screen.dart';

class AnswerQuestionScreenController
    extends MomentumController<AnswerQuestionScreenModel> {
  @override
  AnswerQuestionScreenModel init() {
    return AnswerQuestionScreenModel(
      this,
    );
  }

  @override
  Future bootstrapAsync() => _getColors();

  Future _getColors() async {
    try {
      final colors = await getService<SystemService>().getColorsOfAnswer();
      model.update(colors: colors);
    } catch (e) {
      debugPrint(e.toString());
      if (!model.colors.isExistAndNotEmpty) {
        model.update(colors: [ColorOfAnswer.defaultColor]);
      }
    }
  }
}
