part of '../answer_question_screen.dart';

class AnswerQuestionScreenModel
    extends MomentumModel<AnswerQuestionScreenController> {
  AnswerQuestionScreenModel(
    AnswerQuestionScreenController controller, {
    this.colors,
    this.selectedColor,
    this.backgroundImage,
    this.content,
    this.question,
    this.isSending = false,
  }) : super(controller);

  final List<ColorOfAnswer>? colors;
  final ColorOfAnswer? selectedColor;
  final File? backgroundImage;
  final String? content;
  final Question? question;

  final bool isSending;

  @override
  void update({
    UserImage? userImage,
    List<ColorOfAnswer>? colors,
    ColorOfAnswer? selectedColor,
    File? backgroundImage,
    String? content,
    Question? question,
    bool? isSending,
  }) {
    AnswerQuestionScreenModel(
      controller,
      colors: colors ?? this.colors,
      selectedColor: selectedColor ?? this.selectedColor,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      content: content ?? this.content,
      question: question ?? this.question,
      isSending: isSending ?? this.isSending,
    ).updateMomentum();
  }

  void deleteSelected() {
    AnswerQuestionScreenModel(
      controller,
      backgroundImage: null,
      selectedColor: null,
      colors: colors,
      content: content,
      question: question,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic>? json) {
    return AnswerQuestionScreenModel(
      controller,
      colors: ((json!['colors'] ?? []) as List)
          .map((e) => Mapper.fromJson(e).toObject<ColorOfAnswer>())
          .toList(),
      selectedColor: json['selectedColor'] != null
          ? Mapper.fromJson(json['selectedColor']).toObject<ColorOfAnswer>()
          : null,
      backgroundImage: json['backgroundImagePath'] != null
          ? File(json['backgroundImagePath'])
          : null,
      content: json['content'],
      question: json['question'] != null
          ? Mapper.fromJson(json['question']).toObject<Question>()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'colors': colors?.map((e) => e.toJson()).toList() ?? [],
        'selectedColor': selectedColor?.toJson(),
        'backgroundImagePath': backgroundImage?.path,
        'content': content,
        'question': question?.toJson(),
      };
}
