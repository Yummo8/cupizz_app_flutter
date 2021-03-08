library home_page;

import 'dart:async';
import 'dart:math' as math;

import 'package:cupizz_app/src/helpers/index.dart';
import 'package:cupizz_app/src/screens/main/pages/home/widgets/side_bar.dart';
import 'package:cupizz_app/src/widgets/buttons/like_controls.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/physics.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'widgets/super_like_anim_overlay.dart';

import '../../../../assets.dart';
import '../../../../base/base.dart';
import '../../../../packages/wave/config.dart';
import '../../../../packages/wave/wave.dart';
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
  final _cardController = CCardController();

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            children: [
              // AnimatedBackground(),
              // Positioned(right: 0, left: 15, top: 30, child: _buildHeader()),
              _buildCards(), _buildControls(),
              SideBar(
                controller: _drawerController,
                sideBarSize: constraints.maxWidth,
              ),
              // OptionsDrawer(controller: _drawerController),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildControls() {
    return MomentumBuilder(
        controllers: [RecommendableUsersController],
        builder: (context, snapshot) {
          var model = snapshot<RecommendableUsersModel>()!;
          if (model.users!.isExistAndNotEmpty) {
            return Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Transform.scale(
                scale: 0.8,
                child: LikeControls(
                  onLike: () {
                    if (!_cardController.isAnimating) {
                      Momentum.controller<RecommendableUsersController>(context)
                          .onSwipe(
                        context,
                        isSwipeRight: true,
                        waitForUpdateUi: _cardController.forward(),
                      );
                    }
                  },
                  onDislike: () {
                    if (!_cardController.isAnimating) {
                      Momentum.controller<RecommendableUsersController>(context)
                          .onSwipe(
                        context,
                        waitForUpdateUi: _cardController.forward(
                            direction: SwipDirection.Left),
                      );
                    }
                  },
                  onSuperLike: () {
                    if (!_cardController.isAnimating) {
                      Momentum.controller<RecommendableUsersController>(context)
                          .onSwipe(
                        context,
                        isSuperLike: true,
                        isSwipeRight: true,
                        waitForUpdateUi: _cardController.forward(
                            direction: SwipDirection.Up),
                      );
                    }
                  },
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }

  Widget _buildCards() {
    return MomentumBuilder(
        controllers: [RecommendableUsersController],
        builder: (context, snapshot) {
          var model = snapshot<RecommendableUsersModel>()!;
          if (model.isLoading ||
              !model.users!.isExistAndNotEmpty && !model.isLastPage) {
            if (!model.users!.isExistAndNotEmpty && !model.isLastPage) {
              Momentum.of<RecommendableUsersController>(context)
                  .fetchRecommendableUsers();
            }
            return Center(child: LoadingIndicator());
          } else if (model.error!.isExistAndNotEmpty) {
            return ErrorIndicator(
              moreErrorDetail: model.error,
              onReload: () {
                Momentum.of<RecommendableUsersController>(context)
                    .fetchRecommendableUsers();
              },
            );
          } else if (!model.users!.isExistAndNotEmpty && model.isLastPage) {
            return FadeIn(
              child: Center(
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
              )),
            );
          }

          return CCard(
            controller: _cardController,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: 80,
            ),
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            onEnd: () {
              model.update(isLoading: true);
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
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
            cards: model.users!
                .map((e) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: UserCard(
                        simpleUser: e,
                        onPressed: () {
                          CupertinoScaffold.showCupertinoModalBottomSheet(
                              context: context,
                              builder: (context) => UserScreen(
                                    params: UserScreenParams(user: e),
                                  ));
                        },
                      ),
                    ))
                .toList(),
          );
        });
  }
}
