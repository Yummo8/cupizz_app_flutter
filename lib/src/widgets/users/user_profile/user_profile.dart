import 'dart:math';

import 'package:cupizz_app/src/screens/main/pages/profile/edit_profile_screen.dart';
import 'package:cupizz_app/src/screens/main/pages/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../base/base.dart';

part 'widgets/cart_image.dart';
part 'widgets/custom_clipper.dart';
part 'widgets/profile_sliver_app_bar_delegate.dart';
part 'widgets/row_info.dart';

class UserProfile extends StatefulWidget {
  final SimpleUser user;
  final bool isCurrentUser;
  final bool showBackButton;

  const UserProfile({
    Key key,
    @required this.user,
    this.isCurrentUser = false,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final user = widget.user;

    return PrimaryScaffold(
      body: Skeleton(
        enabled: user == null,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, _) {
            return <Widget>[
              SliverPersistentHeader(
                floating: false,
                pinned: true,
                delegate: _ProfileSliverAppBarDelegate(
                  user,
                  widget.isCurrentUser,
                  expandedHeight: 300,
                  showBackButton: widget.showBackButton,
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            physics: BouncingScrollPhysics(),
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
                    if (widget.isCurrentUser)
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
                if (user == null || user?.address != null) ...[
                  const SizedBox(height: 16.0),
                  RowInfo(
                    iconData: Icons.location_on_rounded,
                    semanticLabel: '',
                    title: user?.address ?? 'Address',
                  ),
                ],
                if (user == null || user?.lookingFor != null) ...[
                  const SizedBox(height: 16.0),
                  RowInfo(
                    iconData: Icons.favorite,
                    semanticLabel: '',
                    title: user?.lookingFor?.displayValue ?? 'Looking for',
                  ),
                ],
                if (user == null || user?.height != null) ...[
                  const SizedBox(height: 16.0),
                  RowInfo(
                    iconData: Icons.height,
                    semanticLabel: '',
                    title: '${user?.height} cm',
                  ),
                ],
                // const SizedBox(height: 16.0),
                // RowInfo(
                //   iconData: Icons.work,
                //   semanticLabel: '',
                //   title: 'LÀM VIỆC TẠI CTY TNHH Freetrend',
                // ),
                // const SizedBox(height: 16.0),
                // RowInfo(
                //   iconData: Icons.school,
                //   semanticLabel: '',
                //   title:
                //       'Trường đại học Công nghệ Thông tin - Đại học Quốc gia TP.HCM, THPT Bến Cát, Bến Cát, Bình Dương',
                // ),
                if (user == null || user.educationLevel != null) ...[
                  const SizedBox(height: 16.0),
                  RowInfo(
                    iconData: Icons.favorite,
                    semanticLabel: '',
                    title:
                        user?.educationLevel?.displayValue ?? 'Education Level',
                  ),
                ],
                // const SizedBox(height: 16.0),
                // RowInfo(
                //   iconData: Icons.house,
                //   semanticLabel: '',
                //   title: 'Quê quán Long Xuyên',
                // ),
                if (user == null || user.yourKids != null) ...[
                  const SizedBox(height: 16.0),
                  RowInfo(
                    iconData: Icons.family_restroom,
                    semanticLabel: '',
                    title: user?.yourKids?.displayValue ?? 'Have kids',
                  ),
                ],
                if (user == null || user.smoking != null) ...[
                  const SizedBox(height: 16.0),
                  RowInfo(
                    iconData: Icons.smoking_rooms,
                    semanticLabel: '',
                    title: user?.smoking?.displayValue ?? 'Smoking',
                  ),
                ],
                if (user == null || user.drinking != null) ...[
                  const SizedBox(height: 16.0),
                  RowInfo(
                    iconData: Icons.local_bar,
                    semanticLabel: '',
                    title: user?.drinking?.displayValue ?? 'Drinking',
                  ),
                ],
                if (user == null || user.religious != null) ...[
                  const SizedBox(height: 16.0),
                  RowInfo(
                    iconData: Icons.self_improvement,
                    semanticLabel: '',
                    title: user?.religious?.displayValue ?? 'religious',
                  ),
                ],
                // const SizedBox(height: 16.0),
                // RowInfo(
                //   iconData: Icons.public,
                //   semanticLabel: '',
                //   title: 'Tiếng việt',
                // ),
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
                    readOnly: !widget.isCurrentUser,
                  ),
                  shrinkWrap: true,
                  itemCount: 6,
                ),
                if (widget.isCurrentUser)
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
      ),
    );
  }
}
