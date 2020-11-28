import 'dart:math';

import 'package:cupizz_app/src/screens/main/pages/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../base/base.dart';

part 'sub_edit_screen/edit_pictrues_screen.dart';
part 'widgets/cart_image.dart';
part 'widgets/custom_clipper.dart';
part 'widgets/row_info.dart';
part 'widgets/stack_container.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController scrollController = ScrollController();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return PrimaryScaffold(
      body: MomentumBuilder(
          controllers: [CurrentUserController],
          builder: (context, snapshot) {
            final model = snapshot<CurrentUserModel>();
            final user = model.currentUser;
            return NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, _) {
                return <Widget>[
                  SliverPersistentHeader(
                    floating: false,
                    pinned: true,
                    delegate: ProfileSliverAppBarDelegate(
                      user,
                      expandedHeight: 300,
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${user?.displayName ?? ''},',
                            style: context.textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          if (user?.age != null)
                            Text(
                              '${user?.age} tuổi',
                              style: context.textTheme.subtitle1,
                            ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: context.colorScheme.primary,
                              size: 16,
                            ),
                            onPressed: () {
                              RouterService.goto(context, EditProfileScreen);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.location_on_rounded,
                        semanticLabel: '',
                        title: 'Đang ở Thành phố Hồ Chí Minh',
                      ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.favorite,
                        semanticLabel: '',
                        title:
                            'Đang ở tìm mối quan hệ lâu dài, kiểu hẹn hò không ràng buộc',
                      ),
                      const SizedBox(height: 16.0),
                      if (user == null || user.height != null)
                        RowInfo(
                          iconData: Icons.height,
                          semanticLabel: '',
                          title: '${user?.height} cm',
                        ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.work,
                        semanticLabel: '',
                        title: 'LÀM VIỆC TẠI CTY TNHH Freetrend',
                      ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.school,
                        semanticLabel: '',
                        title:
                            'Trường đại học Công nghệ Thông tin - Đại học Quốc gia TP.HCM, THPT Bến Cát, Bến Cát, Bình Dương',
                      ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.school,
                        semanticLabel: '',
                        title: 'Bằng đại cao đẳng/đại học',
                      ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.house,
                        semanticLabel: '',
                        title: 'Quê quán Long Xuyên',
                      ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.family_restroom,
                        semanticLabel: '',
                        title: 'Chưa có con',
                      ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.smoking_rooms,
                        semanticLabel: '',
                        title: 'Thỉnh thoảng',
                      ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.local_bar,
                        semanticLabel: '',
                        title: 'Thỉnh thoảng',
                      ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.self_improvement,
                        semanticLabel: '',
                        title: 'Phật giáo',
                      ),
                      const SizedBox(height: 16.0),
                      RowInfo(
                        iconData: Icons.public,
                        semanticLabel: '',
                        title: 'Tiếng việt',
                      ),
                      Divider(
                        color: context.colorScheme.primary,
                        height: 15,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => CartImage(
                          imageUrl:
                              'https://64.media.tumblr.com/1a818212c49bc873a5cb8a687382122e/tumblr_pwnyyjtQ6M1w89qpgo1_1280.jpg',
                        ),
                        shrinkWrap: true,
                        itemCount: 6,
                      ),
                      FlatButton(
                        onPressed: () => {},
                        color: _theme.primaryColor.withOpacity(0.2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: _theme.primaryColor,
                            ),
                            Text(
                              'Thêm ảnh',
                              style: TextStyle(
                                  color: _theme.primaryColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
