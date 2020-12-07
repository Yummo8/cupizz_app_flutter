part of '../select_question_screen.dart';

class SelectQuestionScreenModel
    extends MomentumModel<SelectQuestionScreenController> {
  SelectQuestionScreenModel(
    SelectQuestionScreenController controller, {
    WithIsLastPageOutput<Question> data,
    this.isLoading,
    this.currentPage,
  })  : data =
            data ?? WithIsLastPageOutput<Question>(data: [], isLastPage: false),
        super(controller);

  final WithIsLastPageOutput<Question> data;
  final int currentPage;
  final bool isLoading;

  @override
  void update({
    WithIsLastPageOutput<Question> data,
    int currentPage,
    bool isLoading,
  }) {
    SelectQuestionScreenModel(
      controller,
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return SelectQuestionScreenModel(
      controller,
      data: json['data'] != null
          ? WithIsLastPageOutput.fromJson(json['data'])
          : null,
      currentPage: json['currentPage'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'currentPage': currentPage,
      };
}
