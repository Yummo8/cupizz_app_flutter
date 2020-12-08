import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import '../../../base/base.dart';
part 'compose_bottom_icon_widget.dart';

class AnswerScreenWidget extends StatelessWidget {
  final String questionContent;
  final String answerContent;
  final Color color;
  final Color textColor;
  final List<Color> gradient;
  final File imageFile;
  final String imageUrl;
  final Function onSave;
  final Function onQuestionPressed;
  final Function(String v) onValueChanged;
  final Function(File v) onImageIconSelected;

  const AnswerScreenWidget({
    Key key,
    this.color,
    this.textColor,
    this.gradient,
    this.imageFile,
    this.imageUrl,
    this.onSave,
    this.questionContent,
    this.onQuestionPressed,
    this.answerContent,
    this.onValueChanged,
    this.onImageIconSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final haveImageBackground =
        imageFile != null || imageUrl.isExistAndNotEmpty;
    return PrimaryScaffold(
      body: Container(
        decoration: haveImageBackground
            ? BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageFile != null
                      ? FileImage(imageFile)
                      : CachedNetworkImageProvider(imageUrl),
                ),
              )
            : null,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Opacity(
                opacity: haveImageBackground ? Config.userImageOpacity : 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: gradient.isExistAndNotEmpty ? null : color,
                      gradient: gradient.isExistAndNotEmpty
                          ? AnswerGradient(gradient)
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
                      onPressed: onSave,
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
                        if (questionContent.isExistAndNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.loose,
                                child: InkWell(
                                  onTap: onQuestionPressed,
                                  child: Text(
                                    questionContent,
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
                              initialValue: answerContent,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              textAlign: TextAlign.center,
                              style: context.textTheme.headline6
                                  .copyWith(color: textColor),
                              onChanged: onValueChanged,
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
                    onImageIconSelected: onImageIconSelected,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
