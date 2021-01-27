import 'dart:io';

import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pedantic/pedantic.dart';

import '../../base/base.dart';
import '../../models/index.dart';
import '../../screens/answer_question/widgets/screen_widget.dart';

part 'components/edit_answer_screen.controller.dart';
part 'components/edit_answer_screen.model.dart';

class EditAnswerScreenParams extends RouterParam {
  final UserImage userImage;

  EditAnswerScreenParams(this.userImage);
}

class EditAnswerScreen extends StatelessWidget {
  void _onSubmit(BuildContext context) async {
    final controller = Momentum.controller<EditAnswerScreenController>(context);
    await controller.sendToServer();
    Get.back();

    controller.sendEvent(
        CurrentUserEvent(action: CurrentUserEventAction.newUserImage));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Momentum.controller<EditAnswerScreenController>(context);
    final textEditingController =
        TextEditingController(text: controller.model.content);
    final EditAnswerScreenParams params = Get.arguments;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (params?.userImage == null && controller.model.userImage == null) {
        Get.back();
        Fluttertoast.showToast(msg: 'Đã xảy ra lỗi, vui lòng thử lại.');
      } else if (params?.userImage != null) {
        if (params.userImage != controller.model.userImage) {
          controller.reset();
          controller.model.update(userImage: params.userImage);
          textEditingController.text = params.userImage.answer.content;
        }
      }
    });

    return MomentumBuilder(
        controllers: [EditAnswerScreenController],
        builder: (context, snapshot) {
          final model = snapshot<EditAnswerScreenModel>();
          final colors = model.selectedColor ??
              model.userImage?.colors ??
              ColorOfAnswer.defaultColor;

          return AnswerScreenWidget(
            key: UniqueKey(),
            textEditingController: textEditingController,
            isSending: model.isSending,
            answerContent: model.content ?? model.userImage?.answer?.content,
            color: colors.color,
            textColor: colors.textColor,
            gradient: colors.gradient,
            imageFile: model.backgroundImage,
            imageUrl: model.userImage?.image?.url,
            questionContent: model.userImage?.answer?.question?.content,
            onColorChanged: (color) {
              model.update(selectedColor: color);
            },
            onDeleteSelected: () {
              model.deleteSelected();
            },
            onImageSelected: (v) {
              model.update(backgroundImage: v);
            },
            onSave: () {
              model.update(content: textEditingController.text);
              _onSubmit(context);
            },
          );
        });
  }
}
