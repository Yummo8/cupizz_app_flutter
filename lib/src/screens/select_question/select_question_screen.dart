import 'package:cupizz_app/src/screens/answer_question/answer_question_screen.dart';
import 'package:flutter/material.dart' hide Router;
import '../../base/base.dart';

part 'components/select_question_screen.controller.dart';
part 'components/select_question_screen.model.dart';

class SelectQuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [
          SelectQuestionScreenController,
          AnswerQuestionScreenController
        ],
        builder: (context, snapshot) {
          final model = snapshot<SelectQuestionScreenModel>();
          final modelAnswer = snapshot<AnswerQuestionScreenModel>();
          return PrimaryScaffold(
            appBar: BackAppBar(
              title: 'Chọn câu hỏi',
              showBackButton: modelAnswer.question != null,
            ),
            body: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: model.data.data.length +
                  (model.isLoading
                      ? 10
                      : !model.data.isLastPage
                          ? 2
                          : 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                final color = index <= model.data.data.length - 1
                    ? model.data.data[index].color
                    : ColorOfAnswer.defaultColor.color;
                final gradient = index <= model.data.data.length - 1
                    ? model.data.data[index].gradient
                    : null;
                final item = index <= model.data.data.length - 1
                    ? model.data.data[index]
                    : null;
                return Skeleton(
                  enabled: item == null,
                  child: InkWell(
                    onTap: () {
                      Momentum.controller<AnswerQuestionScreenController>(
                              context)
                          .model
                          .update(question: model.data.data[index]);
                      Router.pop(context);
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: gradient != null ? null : color,
                          gradient: gradient != null
                              ? AnswerGradient(gradient)
                              : null,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: context.colorScheme.onSurface
                                    .withOpacity(0.4),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Text(item?.content ?? '',
                            style: context.textTheme.bodyText1
                                .copyWith(color: item?.textColor))),
                  ),
                );
              },
            ),
          );
        });
  }
}
