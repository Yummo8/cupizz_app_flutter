import 'package:cupizz_app/src/base/base.dart';

class CurrentUserModel extends MomentumModel<CurrentUserController> {
  CurrentUserModel(
    CurrentUserController controller, {
    required this.currentUser,
    this.isLoading = false,
    this.isUpdatingCover = false,
    this.isUpdatingAvatar = false,
    this.isUpdatingSetting = false,
    this.isAddingImage = false,
    this.isDeletingImage = false,
    this.isChangingPass = false,
    List<UserImage>? newOrderList,
  })  : newOrderList = newOrderList ?? [],
        super(controller);

  final User? currentUser;
  // State
  final bool isLoading;
  final bool isUpdatingCover;
  final bool isUpdatingAvatar;
  final bool isUpdatingSetting;
  final bool isAddingImage;
  final bool isDeletingImage;
  final bool isChangingPass;
  final List<UserImage> newOrderList;

  @override
  void update({
    User? currentUser,
    List<UserImage>? newOrderList,
    bool? isLoading,
    bool? isUpdatingCover,
    bool? isUpdatingAvatar,
    bool? isUpdatingSetting,
    bool? isAddingImage,
    bool? isDeletingImage,
    bool? isChangingPass,
  }) {
    CurrentUserModel(
      controller,
      currentUser: currentUser ?? this.currentUser,
      newOrderList: newOrderList ?? this.newOrderList,
      isLoading: isLoading ?? this.isLoading,
      isUpdatingCover: isUpdatingCover ?? this.isUpdatingCover,
      isUpdatingAvatar: isUpdatingAvatar ?? this.isUpdatingAvatar,
      isUpdatingSetting: isUpdatingSetting ?? this.isUpdatingSetting,
      isAddingImage: isAddingImage ?? this.isAddingImage,
      isDeletingImage: isDeletingImage ?? this.isDeletingImage,
      isChangingPass: isChangingPass ?? this.isChangingPass,
    ).updateMomentum();
  }

  void resetNewOrderList() {
    update(newOrderList: [...currentUser!.userImages!]);
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic>? json) {
    return CurrentUserModel(
      controller,
      currentUser: json != null && json['currentUser'] != null
          ? Mapper.fromJson(json['currentUser']).toObject<User>()
          : null,
      newOrderList: json!['newOrderList'] != null
          ? (json['newOrderList'] as List)
              .map((e) => Mapper.fromJson(e).toObject<UserImage>())
              .toList()
          : [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final result = {
      'currentUser': currentUser?.toJson(),
      'newOrderList': newOrderList.map((e) => e.toJson()).toList(),
    };
    return result;
  }
}
