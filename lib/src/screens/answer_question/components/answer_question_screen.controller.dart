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

  Future sendToServer() async {
    try {
      model.update(isSending: true);
      final userImage = await getService<UserService>().answerQuestion(
        model.question?.id,
        model.content,
        backgroundImage: model.backgroundImage,
        color: model.selectedColor?.color?.toHex(leadingHashSign: false),
        textColor:
            model.selectedColor?.textColor?.toHex(leadingHashSign: false),
        gradient: model.selectedColor?.gradient
            ?.map((e) => e.toHex(leadingHashSign: false))
            ?.toList(),
      );
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        unawaited(dependOn<CurrentUserController>().addAnswer(userImage));
        reset();
        UserProfileState.lastScrollOffset = double.maxFinite;
      });
    } catch (e) {
      unawaited(Fluttertoast.showToast(msg: '$e'));
      rethrow;
    } finally {
      model.update(isSending: false);
    }
  }
}
