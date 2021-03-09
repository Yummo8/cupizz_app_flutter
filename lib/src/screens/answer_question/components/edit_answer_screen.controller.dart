part of '../edit_answer_screen.dart';

class EditAnswerScreenController
    extends MomentumController<EditAnswerScreenModel> {
  @override
  EditAnswerScreenModel init() {
    return EditAnswerScreenModel(
      this,
    );
  }

  @override
  Future bootstrapAsync() => _getColors();

  Future _getColors() async {
    try {
      final colors = await Get.find<SystemService>().getColorsOfAnswer();
      model!.update(colors: colors);
    } catch (e) {
      debugPrint(e.toString());
      if (!model!.colors.isExistAndNotEmpty) {
        model!.update(colors: [ColorOfAnswer.defaultColor]);
      }
    }
  }

  Future sendToServer() async {
    try {
      model!.update(isSending: true);
      await _edit();
    } catch (e) {
      unawaited(Fluttertoast.showToast(msg: '$e'));
      rethrow;
    } finally {
      model!.update(isSending: false);
    }
  }

  Future _edit() async {
    await Get.find<UserService>().editAnswer(
      model!.userImage!.answer!.id,
      content: model!.content,
      backgroundImage: model!.backgroundImage,
      color: model!.selectedColor?.color,
      textColor: model!.selectedColor?.textColor,
      gradient: model!.selectedColor?.gradient,
    );
    await dependOn<CurrentUserController>().getCurrentUser();
  }
}
