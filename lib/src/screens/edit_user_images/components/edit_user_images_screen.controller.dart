part of '../edit_user_images_screen.dart';

class EditUserImagesScreenController
    extends MomentumController<EditUserImagesScreenModel> {
  @override
  EditUserImagesScreenModel init() {
    return EditUserImagesScreenModel(
      this,
    );
  }

  void changeOrder(int oldIndex, int newIndex) {
    if (!model.newOrderList.isExistAndNotEmpty) {
      model.newOrderList.addAll(
          dependOn<CurrentUserController>().model.currentUser.userImages);
    }
    final userImage = model.newOrderList.removeAt(oldIndex);
    model.newOrderList.insert(newIndex, userImage);
    model.update(newOrderList: model.newOrderList);
  }
}
