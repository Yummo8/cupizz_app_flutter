import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupizz_app/src/base/base.dart';
import 'package:cupizz_app/src/models/index.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'components/answer_question_screen.controller.dart';
part 'components/answer_question_screen.model.dart';
part 'widgets/app_bar.dart';
part 'widgets/compose_bottom_icon_widget.dart';
part 'widgets/widgets.dart';

class AnswerQuestionScreenParams extends RouterParam {
  final UserImage userImage;

  AnswerQuestionScreenParams({this.userImage});
}

class AnswerQuestionScreen extends StatelessWidget {
  void _onSubmit(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _onImageIconSelected(BuildContext context, File file) {
    if (file != null) {
      Momentum.controller<AnswerQuestionScreenController>(context)
          .model
          .update(backgroundImage: file);
    }
  }

  String _getTextFieldPlaceholder() {
    return 'Hôm nay bạn thế nào?';
  }

  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [AnswerQuestionScreenController],
        builder: (context, snapshot) {
          final model = snapshot<AnswerQuestionScreenModel>();
          final params = Router.getParam<AnswerQuestionScreenParams>(context);
          if (params?.userImage != null &&
              model.userImage != params?.userImage) {
            model.update(userImage: params.userImage);
          }

          final haveImageBackground =
              model.backgroundImage != null || model.userImage?.image != null;
          final backgroundColor = model.selectedColor != null
              ? model.selectedColor.color
              : model.userImage?.answer?.color != null
                  ? model.userImage.answer.color
                  : model.userImage?.answer?.question?.color ??
                      ColorOfAnswer.defaultColor.color;
          final textColor = model.selectedColor != null
              ? model.selectedColor.textColor
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
                      opacity: haveImageBackground ? 0.5 : 1,
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
                      _AppBar(
                        onActionPressed: _onSubmit,
                        isCrossButton: true,
                        submitButtonText: 'Đăng',
                        isSubmitDisable: false,
                        isbootomLine: true,
                        textColor: textColor,
                      ),
                      Expanded(
                        child: Container(
                          height: context.height,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              if (model.question != null)
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(
                                            model.question?.content ?? '',
                                            style: context.textTheme.bodyText1
                                                .copyWith(color: textColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              Expanded(
                                child: Center(
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) =>
                                        model.update(content: value),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: _getTextFieldPlaceholder(),
                                      hintStyle: TextStyle(
                                          fontSize: 18, color: textColor),
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
