part of '../answer_question_screen.dart';

class AnswerQuestionScreenModel
    extends MomentumModel<AnswerQuestionScreenController> {
  AnswerQuestionScreenModel(
    AnswerQuestionScreenController controller, {
    this.userImage,
    this.colors,
    this.selectedColor,
    this.backgroundImage,
    this.content,
    this.question,
  }) : super(controller);

  // Use for editing screen.
  final UserImage userImage;
  final List<ColorOfAnswer> colors;
  final ColorOfAnswer selectedColor;
  final File backgroundImage;
  final String content;
  final Question question;

  @override
  void update({
    UserImage userImage,
    List<ColorOfAnswer> colors,
    ColorOfAnswer selectedColor,
    File backgroundImage,
    String content,
    Question question,
  }) {
    AnswerQuestionScreenModel(
      controller,
      userImage: userImage ?? this.userImage,
      colors: colors ?? this.colors,
      selectedColor: selectedColor ?? this.selectedColor,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      content: content ?? this.content,
      question: question ?? this.question,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return AnswerQuestionScreenModel(
      controller,
      userImage: json['userImage'] != null
          ? Mapper.fromJson(json['userImage']).toObject<UserImage>()
          : null,
      colors: ((json['colors'] ?? []) as List)
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
        'userImage': userImage?.toJson(),
        'colors': colors?.map((e) => e.toJson())?.toList() ?? [],
        'selectedColor': selectedColor?.toJson(),
        'backgroundImagePath': backgroundImage?.path,
        'content': content,
        'question': question?.toJson(),
      };
}
