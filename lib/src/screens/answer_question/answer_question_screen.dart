import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/models/index.dart';
import 'package:cupizz_app/src/screens/select_question/select_question_screen.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pedantic/pedantic.dart';

part 'components/answer_question_screen.controller.dart';
part 'components/answer_question_screen.model.dart';
part 'widgets/compose_bottom_icon_widget.dart';

class AnswerQuestionScreenParams extends RouterParam {
  final UserImage userImage;
  final Function onSaveSuccess;

  AnswerQuestionScreenParams({this.userImage, this.onSaveSuccess});
}

class AnswerQuestionScreen extends StatelessWidget {
  void _onSubmit(BuildContext context) async {
    final controller =
        Momentum.controller<AnswerQuestionScreenController>(context);
    await controller.sendToServer();
    Router.pop(context);

    controller.sendEvent(
        CurrentUserEvent(action: CurrentUserEventAction.newUserImage));
  }

  void _onImageIconSelected(BuildContext context, File file) async {
    if (file != null) {
      await Momentum.controller<AnswerQuestionScreenController>(context)
          .model
          .update(backgroundImage: file);
    }
  }

  void _selectQuestion(BuildContext context) {
    Router.goto(context, SelectQuestionScreen);
  }

  @override
  Widget build(BuildContext context) {
    final params = Router.getParam<AnswerQuestionScreenParams>(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Momentum.controller<AnswerQuestionScreenController>(context)
              .model
              .question ==
          null) {
        _selectQuestion(context);
      }
    });
    return MomentumBuilder(
        controllers: [AnswerQuestionScreenController],
        builder: (context, snapshot) {
          final model = snapshot<AnswerQuestionScreenModel>();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (params?.userImage != null &&
                model.userImage != params?.userImage) {
              model.update(userImage: params.userImage);
            }
          });

          final haveImageBackground =
              model.backgroundImage != null || model.userImage?.image != null;
          final backgroundColor = model.selectedColor != null
              ? model.selectedColor.color
              : model.question?.color != null
                  ? model.question.color
                  : model.userImage?.answer?.color != null
                      ? model.userImage.answer.color
                      : model.userImage?.answer?.question?.color ??
                          ColorOfAnswer.defaultColor.color;
          final textColor = model.selectedColor != null
              ? model.selectedColor.textColor
              : model.question?.textColor != null
                  ? model.question.textColor
                  : model.userImage?.answer?.textColor != null
                      ? model.userImage.answer.textColor
                      : model.userImage?.answer?.question?.textColor ??
                          ColorOfAnswer.defaultColor.textColor;
          final backgroundGradient = model.selectedColor != null
              ? model.selectedColor.gradient
              : model.userImage?.answer != null
                  ? model.userImage.answer.gradient
                  : null;

          return PrimaryScaffold(
            body: Container(
              decoration: haveImageBackground
                  ? BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: model.backgroundImage != null
                            ? FileImage(model.backgroundImage)
                            : CachedNetworkImageProvider(
                                model.userImage.image?.url),
                      ),
                    )
                  : null,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Opacity(
                      opacity:
                          haveImageBackground ? Config.userImageOpacity : 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: backgroundGradient != null
                                ? null
                                : backgroundColor,
                            gradient: backgroundGradient != null
                                ? AnswerGradient(backgroundGradient)
                                : null),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      BackAppBar(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        textColor: textColor,
                        actions: [
                          SaveButton(
                            onPressed: () {
                              if (model.content.isExistAndNotEmpty &&
                                  !model.isSending) _onSubmit(context);
                            },
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          height: context.height,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              if (model.question != null) ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: InkWell(
                                        onTap: () {
                                          _selectQuestion(context);
                                        },
                                        child: Text(
                                          model.question?.content ?? '',
                                          style: context.textTheme.bodyText1
                                              .copyWith(color: textColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                              Expanded(
                                child: Center(
                                  child: TextFormField(
                                    initialValue: model.content,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.headline6
                                        .copyWith(color: textColor),
                                    onChanged: (value) =>
                                        model.update(content: value),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Câu trả lời ...',
                                      hintStyle: context.textTheme.headline6
                                          .copyWith(color: textColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ComposeBottomIconWidget(
                          onImageIconSelected: (file) =>
                              _onImageIconSelected(context, file),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
