library edit_profile_screen;

import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:geolocator/geolocator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../base/base.dart';

part 'sub_edit_screen/edit_age_screen.dart';
part 'sub_edit_screen/edit_drink_screen.dart';
part 'sub_edit_screen/edit_education_level_screen.dart';
part 'sub_edit_screen/edit_gender_screen.dart';
part 'sub_edit_screen/edit_height_screen.dart';
part 'sub_edit_screen/edit_hobbies_screen.dart';
part 'sub_edit_screen/edit_location_screen.dart';
part 'sub_edit_screen/edit_lookup_screen.dart';
part 'sub_edit_screen/edit_marriage_screen.dart';
part 'sub_edit_screen/edit_pictures_screen.dart';
part 'sub_edit_screen/edit_religion_screen.dart';
part 'sub_edit_screen/edit_smoke_screen.dart';
part 'sub_edit_screen/edit_text_screen.dart';
part 'widgets/custom_check_box_group.dart';
part 'widgets/custom_item_choice.dart';
part 'widgets/custom_radio_button_group.dart';
part 'widgets/multi_select_hobby.dart';
part 'widgets/multiselect_dialog_hobby.dart';
part 'widgets/row_edit_info.dart';
part 'widgets/show_on_profile_text.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with KeepScrollOffsetMixin {
  CurrentUserModel model;
  User user;
  String bio;

  static double lastScrollOffset = 0;

  @override
  double get lastOffset => lastScrollOffset;

  @override
  set lastOffset(double value) => lastScrollOffset = value;

  @override
  void initState() {
    super.initState();
  }

  void _onBioChanged(String value) {
    if (value.isExistAndNotEmpty) {
      setState(() {
        bio = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(title: Strings.editProfile.title),
      body: MomentumBuilder(
          controllers: [CurrentUserController],
          builder: (context, snapshot) {
            model = snapshot<CurrentUserModel>();
            user = model.currentUser;
            return SingleChildScrollView(
              controller: scrollController,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.editProfile.introduction,
                        style: context.textTheme.headline6
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: sizeHelper.rW(0.5)),
                        child: TextFormField(
                          // autovalidate: true,
                          initialValue: user.introduction,
                          onChanged: _onBioChanged,
                          autocorrect: false,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          style: context.textTheme.bodyText1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'Hãy mô tả bản thân bạn bằng vài từ hoặc câu...',
                            hintStyle: context.textTheme.bodyText1
                                .copyWith(color: context.colorScheme.onSurface),
                          ),
                        ),
                      ),
                      if (bio.isExistAndNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${bio.length}/500',
                              style: context.textTheme.caption,
                            ),
                            InkWell(
                              onTap: () {
                                model.controller
                                    .updateProfile(introduction: bio);
                                setState(() {
                                  bio = '';
                                });
                              },
                              child: Text(
                                Strings.button.save,
                                style: context.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    indent: 0,
                    endIndent: 0,
                    height: 10.0,
                    color: context.colorScheme.onSurface,
                  ),
                  const SizedBox(height: 10.0),
                  buildBasicInfo(sizeHelper),
                  buildJobAndEducation(sizeHelper),
                  buildLifeStyle(sizeHelper),
                  buildReligion(sizeHelper),
                  buildFavorites(sizeHelper)
                ],
              ),
            );
          }),
    );
  }

  Widget buildWrapperRowEditInfo(
      String title, List<Widget> listWidgetItems, SizeHelper sizeHelper) {
    var children = <Widget>[];
    children.add(Text(
      title,
      style: context.textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
    ));
    children.add(const SizedBox(height: 10.0));
    for (var widget in listWidgetItems) {
      children.add(widget);
      children.add(const SizedBox(height: 10));
    }
    children.add(Divider(
      thickness: 1.0,
      indent: 0,
      endIndent: 0,
      height: 30.0,
      color: context.colorScheme.onSurface,
    ));
    children.add(const SizedBox(height: 10.0));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget buildBasicInfo(SizeHelper sizeHelper) {
    var listWidgetItems = <Widget>[];

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: 'Tên',
      value: user?.nickName,
      onClick: () {
        Router.goto(context, EditTextScreen,
            params: EditTextScreenParams(
              title: 'Tên',
              value: user.nickName,
              onSave: (value) {
                model.controller.updateProfile(nickName: value);
              },
            ));
      },
    ));

    listWidgetItems.add(RowEditInfo(
        iconData: Icons.info,
        title: 'Độ tuổi',
        value: user?.age?.toString(),
        onClick: () {
          Router.goto(context, EditAgeScreen);
        }));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.location_on_rounded,
      title: 'Vị trí hẹn hò',
      value: user?.address != null ? 'Đang ở ${user.address}' : null,
      onClick: () {
        Router.goto(context, EditLocationScreen);
      },
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: MdiIcons.human,
      title: 'Giới tính',
      value: user?.gender?.displayValue,
      onClick: () {
        Router.goto(context, EditGenderScreen);
      },
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.account_circle_outlined,
      title: 'Đang tìm kiếm',
      value: user?.lookingFor?.displayValue,
      onClick: () {
        Router.goto(context, EditLookupScreen);
      },
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.height,
      title: 'Chiều cao',
      value: user?.height != null ? '${user?.height}cm' : null,
      onClick: () {
        Router.goto(context, EditHeightScreen);
      },
    ));

    // listWidgetItems.add(RowEditInfo(
    //   iconData: Icons.house,
    //   title: 'Quê quán',
    //   value: 'Bến Cát, Bình Dương, Viet Nam',
    // ));

    return buildWrapperRowEditInfo(
        'Thông tin cơ bản của bạn', listWidgetItems, sizeHelper);
  }

  Widget buildJobAndEducation(SizeHelper sizeHelper) {
    var listWidgetItems = <Widget>[];

    // listWidgetItems.add(RowEditInfo(
    //   iconData: Icons.work,
    //   title: 'Chức danh',
    //   value: '-',
    //   onClick: () {
    //     Router.goto(context, EditTextScreen,
    //         params: EditTextScreenParams(
    //           title: 'Chức danh',
    //           onSave: (value) {},
    //         ));
    //   },
    // ));

    // listWidgetItems.add(RowEditInfo(
    //   iconData: Icons.work,
    //   title: 'Công ty',
    //   value: '-',
    //   onClick: () {
    //     Router.goto(context, EditTextScreen,
    //         params: EditTextScreenParams(
    //           title: 'Bạn đang làm việc ở đâu',
    //           onSave: (value) {},
    //         ));
    //   },
    // ));

    // listWidgetItems.add(RowEditInfo(
    //   iconData: Icons.school,
    //   title: 'Trường trung học',
    //   value: '-',
    //   onClick: () {
    //     Router.goto(context, EditTextScreen,
    //         params: EditTextScreenParams(
    //           title: 'Trường trung học',
    //           onSave: (value) {},
    //         ));
    //   },
    // ));

    // listWidgetItems.add(RowEditInfo(
    //   iconData: Icons.school,
    //   title: 'Trường đại học cao/cao đẳng',
    //   value: '-',
    //   onClick: () {
    //     Router.goto(context, EditTextScreen,
    //         params: EditTextScreenParams(
    //           title: 'Trường đại học cao/cao đẳng',
    //           onSave: (value) {},
    //         ));
    //   },
    // ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.school,
      title: 'Trình độ học vấn',
      value: user?.educationLevel?.displayValue,
      onClick: () {
        Router.goto(context, EditEducationLevelScreen);
      },
    ));
    return buildWrapperRowEditInfo(
        'Công việc và học vấn của bạn', listWidgetItems, sizeHelper);
  }

  Widget buildLifeStyle(SizeHelper sizeHelper) {
    var listWidgetItems = <Widget>[];
    listWidgetItems.add(RowEditInfo(
      iconData: Icons.family_restroom,
      title: 'Con bạn',
      value: user?.yourKids?.displayValue,
      onClick: () {
        Router.goto(context, EditMarriageScreen);
      },
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.smoking_rooms,
      title: 'Hút thuốc',
      value: user?.smoking?.displayValue,
      onClick: () {
        Router.goto(context, EditSmokeScreen);
      },
    ));

    listWidgetItems.add(RowEditInfo(
      iconData: Icons.local_bar,
      title: 'Uống rượu',
      value: user?.drinking?.displayValue,
      onClick: () {
        Router.goto(context, EditDrinkScreen);
      },
    ));
    return buildWrapperRowEditInfo(
        'Lối sống của bạn', listWidgetItems, sizeHelper);
  }

  Widget buildReligion(SizeHelper sizeHelper) {
    var listWidgetItems = <Widget>[];
    listWidgetItems.add(RowEditInfo(
      iconData: Icons.self_improvement,
      title: 'Quan điểm tôn giáo',
      value: user?.religious?.displayValue,
      onClick: () {
        Router.goto(context, EditReligionScreen);
      },
    ));

    return buildWrapperRowEditInfo(
        'Lối sống của bạn', listWidgetItems, sizeHelper);
  }

  Widget buildFavorites(SizeHelper sizeHelper) {
    var listWidgetItems = <Widget>[];
    listWidgetItems.add(CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Router.goto(context, EditHobbiesScreen);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: context.colorScheme.onSurface,
        ),
        padding: EdgeInsets.all(sizeHelper.rW(2)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: sizeHelper.rW(6.0),
              color: context.colorScheme.background,
            ),
            SizedBox(height: sizeHelper.rW(3)),
            Text('Thêm sở thích',
                style: context.textTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.background,
                ))
          ],
        ),
      ),
    ));

    return buildWrapperRowEditInfo(
        'Sở thích của bạn', listWidgetItems, sizeHelper);
  }
}
