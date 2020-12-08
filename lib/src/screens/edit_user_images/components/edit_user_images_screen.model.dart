part of '../edit_user_images_screen.dart';

class EditUserImagesScreenModel
    extends MomentumModel<EditUserImagesScreenController> {
  EditUserImagesScreenModel(EditUserImagesScreenController controller)
      : super(controller);

  @override
  void update() {
    EditUserImagesScreenModel(
      controller,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return EditUserImagesScreenModel(controller);
  }

  @override
  Map<String, dynamic> toJson() => {};
}
