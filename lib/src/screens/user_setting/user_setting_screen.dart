library user_setting_screen;

import 'package:sliding_sheet/sliding_sheet.dart';

import '../../base/base.dart';
import 'package:flutter/material.dart';

part 'widgets/text_tile.dart';
part 'widgets/setting_noti_bottom_sheet.dart';

class UserSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [CurrentUserController],
        builder: (context, snapshot) {
          final model = snapshot<CurrentUserModel>();
          return PrimaryScaffold(
            appBar: BackAppBar(
              title: 'Cài đặt',
              actions: [
                if (model.isUpdatingSetting) Center(child: Text('Đang lưu...'))
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  TitleToggle(
                    paddingAbove: const EdgeInsets.symmetric(horizontal: 10),
                    paddingBelow: const EdgeInsets.all(10),
                    title: 'Cho phép người khác thích bạn',
                    description:
                        'Nếu bật tính năng này, thông tin của bạn sẽ được gợi ý cho người dùng phù hợp tại trang chủ của ứng dụng.',
                    value: model.currentUser?.allowMatching ?? false,
                    divider: true,
                    valueChanged: (value) {
                      if (value != null) {
                        model.controller.updateSetting(allowMatching: value);
                      }
                    },
                  ),
                  TitleToggle(
                    paddingAbove: const EdgeInsets.symmetric(horizontal: 10),
                    paddingBelow: const EdgeInsets.all(10),
                    title: 'Hiển thị trạng thái hoạt động',
                    description:
                        'Cho phép người dùng khác biết được thời điểm lần cuối truy cập của bạn trên ứng dụng Cupizz. Khi tắt tính năng này, bạn sẽ không thể thấy trạng thái hoạt động của các người dùng khác.',
                    value: model.currentUser?.showActive ?? false,
                    divider: true,
                    valueChanged: (value) {
                      if (value != null) {
                        model.controller.updateSetting(showActive: value);
                      }
                    },
                  ),
                  _TextTile(
                    text: 'Cài đặt thông báo',
                    onTap: () {
                      _SettingNotiBottomSheet(context).show();
                    },
                  ),
                  if (model.currentUser.socialProviders.firstWhere(
                          (e) => e.type == SocialProviderType.email,
                          orElse: () => null) !=
                      null) ...[
                    Divider(),
                    _TextTile(
                      text: 'Đổi mật khẩu',
                      onTap: () {
                        final controller =
                            Momentum.controller<CurrentUserController>(context);
                        if (controller.model.currentUser != null) {
                          ChangePassDialog.show(
                            context,
                            avatar: controller.model.currentUser.avatar?.url,
                            nickName: controller.model.currentUser.nickName,
                            isLoading: false,
                            requireOldPass: true,
                            onSend: (oldPass, newPass) async {
                              await controller.changePassword(oldPass, newPass);
                            },
                          );
                        }
                      },
                    ),
                  ],
                  Divider(),
                  _TextTile(
                    text: 'Đăng xuất',
                    onTap: () {
                      Momentum.controller<AuthController>(context).logout();
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        });
  }
}
