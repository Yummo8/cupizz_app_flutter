part of '../select_question_screen.dart';

class SelectQuestionScreenController
    extends MomentumController<SelectQuestionScreenModel> {
  @override
  SelectQuestionScreenModel init() {
    return SelectQuestionScreenModel(
      this,
    );
  }

  @override
  Future bootstrapAsync() async {
    model!.update(isLoading: true);
    await _reload();
    model!.update(isLoading: false);
  }

  Future loadMore() async {
    final result = await Get.find<SystemService>()
        .getQuestions(page: model!.currentPage! + 1);
    model!.update(
        data: model!.data..add(result), currentPage: model!.currentPage! + 1);
  }

  Future _reload() async {
    final result = await Get.find<SystemService>().getQuestions(page: 1);
    model!.update(data: result);
  }
}
