part of '../edit_user_images_screen.dart';

class EditUserImagesScreenModel
    extends MomentumModel<EditUserImagesScreenController> {
  EditUserImagesScreenModel(EditUserImagesScreenController controller,
      {List<UserImage> newOrderList})
      : newOrderList = newOrderList ?? [],
        super(controller);

  final List<UserImage> newOrderList;

  @override
  void update({List<UserImage> newOrderList}) {
    EditUserImagesScreenModel(
      controller,
      newOrderList: newOrderList ?? this.newOrderList,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return EditUserImagesScreenModel(
      controller,
      newOrderList: json['newOrderList'] != null
          ? (json['newOrderList'] as List)
              .map((e) => Mapper.fromJson(e).toObject<UserImage>())
              .toList()
          : [],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'newOrderList': newOrderList?.map((e) => e.toJson())?.toList() ?? [],
      };
}
