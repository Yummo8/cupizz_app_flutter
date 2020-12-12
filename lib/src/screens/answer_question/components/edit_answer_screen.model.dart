part of '../edit_answer_screen.dart';

class EditAnswerScreenModel extends MomentumModel<EditAnswerScreenController> {
  EditAnswerScreenModel(
    EditAnswerScreenController controller, {
    this.userImage,
    this.colors,
    this.selectedColor,
    this.backgroundImage,
    this.content,
    this.isSending = false,
  }) : super(controller);

  final UserImage userImage;
  final List<ColorOfAnswer> colors;
  final ColorOfAnswer selectedColor;
  final File backgroundImage;
  final String content;

  final bool isSending;

  @override
  void update({
    UserImage userImage,
    List<ColorOfAnswer> colors,
    ColorOfAnswer selectedColor,
    File backgroundImage,
    String content,
    Question question,
    bool isSending,
  }) {
    EditAnswerScreenModel(
      controller,
      userImage: userImage ?? this.userImage,
      colors: colors ?? this.colors,
      selectedColor: selectedColor ?? this.selectedColor,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      content: content ?? this.content,
      isSending: isSending ?? this.isSending,
    ).updateMomentum();
  }

  void deleteSelected() {
    EditAnswerScreenModel(
      controller,
      backgroundImage: null,
      selectedColor: null,
      userImage: userImage,
      colors: colors,
      content: content,
    ).updateMomentum();
  }

  void deleteUserImage() {
    EditAnswerScreenModel(
      controller,
      backgroundImage: backgroundImage,
      selectedColor: selectedColor,
      userImage: null,
      colors: colors,
      content: content,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return EditAnswerScreenModel(
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
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'userImage': userImage?.toJson(),
        'colors': colors?.map((e) => e.toJson())?.toList() ?? [],
        'selectedColor': selectedColor?.toJson(),
        'backgroundImagePath': backgroundImage?.path,
        'content': content,
      };
}
