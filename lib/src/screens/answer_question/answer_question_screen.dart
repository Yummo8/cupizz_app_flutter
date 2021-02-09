import 'dart:io';

import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/models/index.dart';
import 'package:cupizz_app/src/screens/answer_question/widgets/screen_widget.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pedantic/pedantic.dart';

part 'components/answer_question_screen.controller.dart';
part 'components/answer_question_screen.model.dart';

class AnswerQuestionScreen extends StatelessWidget {
  static void answerQuestion(BuildContext context) {
    final controller =
        Momentum.controller<AnswerQuestionScreenController>(context);
    if (controller.model.question == null) {
      _selectQuestion(context);
    } else {
      Get.toNamed(Routes.answer);
    }
  }

  static void _selectQuestion(BuildContext context) {
    Get.toNamed(Routes.selectQuestion);
  }

  void _onSubmit(BuildContext context) async {
    final controller =
        Momentum.controller<AnswerQuestionScreenController>(context);
    await controller.sendToServer();
    Get.back();

    controller.sendEvent(
        CurrentUserEvent(action: CurrentUserEventAction.newUserImage));
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        Momentum.controller<AnswerQuestionScreenController>(context);
    final textEditingController =
        TextEditingController(text: controller.model.content);

    return MomentumBuilder(
        controllers: [AnswerQuestionScreenController],
        builder: (context, snapshot) {
          final model = snapshot<AnswerQuestionScreenModel>();
          final colors = model.selectedColor ??
              model.question?.colors ??
              ColorOfAnswer.defaultColor;

          return AnswerScreenWidget(
            key: UniqueKey(),
            textEditingController: textEditingController,
            isSending: model.isSending,
            answerContent: model.content,
            color: colors.color,
            textColor: colors.textColor,
            gradient: colors.gradient,
            imageFile: model.backgroundImage,
            questionContent: model.question?.content,
            onColorChanged: (color) {
              model.update(selectedColor: color);
            },
            onDeleteSelected: () {
              model.deleteSelected();
            },
            onImageSelected: (v) {
              model.update(backgroundImage: v);
            },
            onQuestionPressed: () {
              _selectQuestion(context);
            },
            onSave: () {
              model.update(content: textEditingController.text);
              _onSubmit(context);
            },
          );
        });
  }
}
