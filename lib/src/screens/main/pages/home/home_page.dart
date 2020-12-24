library home_page;

import 'dart:async';
import 'dart:math' as math;

import 'package:cupizz_app/src/helpers/index.dart';
import 'package:cupizz_app/src/screens/main/pages/profile/profile_page.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/physics.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../../assets.dart';
import '../../../../base/base.dart';
import '../../../../widgets/index.dart';

part 'widgets/animated_background.dart';
part 'widgets/c_card.dart';
part 'widgets/options_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _drawerController = OptionsDrawerController();
  final _headerHeight = 75.0;

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            AnimatedBackground(),
            Positioned(right: 0, left: 15, top: 30, child: _buildHeader()),
            Positioned.fill(child: _buildCards()),
            OptionsDrawer(controller: _drawerController),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MomentumBuilder(
            controllers: [CurrentUserController],
            builder: (context, snapshot) {
              final model = snapshot<CurrentUserModel>();
              return model.currentUser != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(
                          color:
                              context.colorScheme.background.withOpacity(0.2),
                          width: 4,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Router.goto(context, ProfilePage);
                        },
                        child: UserAvatar.fromChatUser(
                          user: model.currentUser,
                          size: 38,
                          showOnline: false,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
          OpacityIconButton(
            icon: Icons.tune,
            onPressed: () {
              _drawerController.openMenu();
            },
          ),
        ],
      );
    });
  }

  Widget _buildCards() {
    return MomentumBuilder(
        controllers: [RecommendableUsersController],
        builder: (context, snapshot) {
          var model = snapshot<RecommendableUsersModel>();
          if (model.isLoading || model.users == null) {
            return LoadingIndicator();
          } else if (model.error.isExistAndNotEmpty) {
            return ErrorIndicator(
              moreErrorDetail: model.error,
              onReload: () {
                Momentum.of<RecommendableUsersController>(context)
                    .fetchRecommendableUsers();
              },
            );
          } else if (!model.users.isExistAndNotEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hiện tại chúng tôi không còn gợi ý ghép đôi dành cho bạn.\nHãy thử thay đổi mẫu người mà bạn tìm kiếm.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                OptionButton(
                  title: 'Đổi cài đặt',
                  isSelected: true,
                  onPressed: () {
                    _drawerController.openMenu();
                  },
                ),
              ],
            ));
          }

          return CCard(
            padding: EdgeInsets.only(top: _headerHeight + 50),
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            onEnd: () {
              model.update(isLoading: true);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                model.update(isLoading: false);
              });
            },
            onSwipeLeft: () {
              Momentum.controller<RecommendableUsersController>(context)
                  .onSwipe(context);
            },
            onSwipeRight: () {
              Momentum.controller<RecommendableUsersController>(context)
                  .onSwipe(context, isSwipeRight: true);
            },
            cards: model.users
                .map((e) => ClipRRect(
                      child: UserCard(
                        simpleUser: e,
                        onPressed: () {
                          Router.goto(context, UserScreen,
                              params: UserScreenParams(user: e));
                        },
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ))
                .toList(),
          );
        });
  }
}
