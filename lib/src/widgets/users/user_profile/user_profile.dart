import 'dart:math';

import 'package:cupizz_app/src/screens/answer_question/answer_question_screen.dart';
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
  final Future Function() onRefresh;

  const UserProfile({
    Key key,
    @required this.user,
    this.isCurrentUser = false,
    this.showBackButton = false,
    this.onRefresh,
  }) : super(key: key);

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends MomentumState<UserProfile>
    with KeepScrollOffsetMixin {
  static double lastScrollOffset = 0;

  @override
  double get lastOffset => lastScrollOffset;

  @override
  set lastOffset(double value) {
    lastScrollOffset = value;
  }

  @override
  void initState() {
    super.initState();
    if (widget.isCurrentUser) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Momentum.controller<CurrentUserController>(context)
            .listen<CurrentUserEvent>(
                state: this,
                invoke: (event) {
                  switch (event.action) {
                    case CurrentUserEventAction.newUserImage:
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          curve: Curves.easeIn,
                          duration: Duration(seconds: 1),
                        );
                      });
                      break;
                    default:
                  }
                });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final user = widget.user;

    return PrimaryScaffold(
      body: Skeleton(
        enabled: user == null,
        child: RefreshIndicator(
          onRefresh: () async {
            await Momentum.controller<CurrentUserController>(context)
                .getCurrentUser();
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
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
              SliverList(
                  delegate: SliverChildListDelegate([
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
                          Router.goto(context, EditProfileScreen);
                        },
                      ),
                  ],
                ),
                if (user == null || user?.introduction != null) ...[
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(user?.introduction ?? '',
                        style: context.textTheme.subtitle2),
                  )
                ],
                if (user == null || user?.address != null) ...[
                  const SizedBox(height: 16.0),
                  RowInfo(
                    iconData: Icons.location_on_rounded,
                    semanticLabel: '',
                    title: 'Đang ở ${user?.address ?? 'Address'}',
                  ),
                ],
                if (user == null || user.lookingFors.isExistAndNotEmpty) ...[
                  const SizedBox(height: 16.0),
                  RowInfo(
                    iconData: Icons.favorite,
                    semanticLabel: '',
                    title: user?.lookingFors
                            ?.map((e) => e.displayValue)
                            ?.toList()
                            ?.join(', ') ??
                        'Looking for',
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
                    iconData: Icons.school,
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
                    userImage: (user?.userImages ?? [])[index],
                    readOnly: !widget.isCurrentUser,
                  ),
                  shrinkWrap: true,
                  itemCount: user?.userImages?.length ?? 0,
                ),
                if (widget.isCurrentUser)
                  MomentumBuilder(
                      controllers: [CurrentUserController],
                      builder: (context, snapshot) {
                        final model = snapshot<CurrentUserModel>();
                        if (model.isAddingImage) return LoadingIndicator();
                        return Column(
                          children: [
                            FlatButton(
                              onPressed: model.isAddingImage
                                  ? null
                                  : () {
                                      pickImage(context, (files) {
                                        if (files.isExistAndNotEmpty) {
                                          model.controller.addImage(files[0]);
                                        }
                                      }, maxSelected: 1);
                                    },
                              color: _theme.primaryColor.withOpacity(0.2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  model.isAddingImage
                                      ? LoadingIndicator(size: 20)
                                      : Icon(
                                          Icons.image,
                                          color: _theme.primaryColor,
                                        ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Thêm ảnh',
                                    style: TextStyle(
                                        color: _theme.primaryColor,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            FlatButton(
                              onPressed: model.isAddingImage
                                  ? null
                                  : () {
                                      Router.goto(
                                        context,
                                        AnswerQuestionScreen,
                                        params: AnswerQuestionScreenParams(),
                                      );
                                    },
                              color: _theme.primaryColor.withOpacity(0.2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  model.isAddingImage
                                      ? LoadingIndicator(size: 20)
                                      : Icon(
                                          Icons.help_outline,
                                          color: _theme.primaryColor,
                                        ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Trả lời câu hỏi',
                                    style: TextStyle(
                                        color: _theme.primaryColor,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      })
              ]
                      .map((e) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: e,
                          ))
                      .toList()))
            ],
          ),
        ),
      ),
    );
  }
}
