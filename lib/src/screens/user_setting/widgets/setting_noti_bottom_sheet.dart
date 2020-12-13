part of '../user_setting_screen.dart';

class _SettingNotiBottomSheet {
  final BuildContext context;

  _SettingNotiBottomSheet(this.context);

  void show() async {
    return await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        headerBuilder: (context, state) {
          return Material(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Thông báo', style: context.textTheme.headline6),
            ),
          );
        },
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return MomentumBuilder(
              controllers: [CurrentUserController],
              builder: (context, snapshot) {
                final model = snapshot<CurrentUserModel>();
                return Column(
                  children: [
                    ...NotificationType.getAll()
                        .map((e) => TitleToggle(
                              paddingAbove:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              paddingBelow: const EdgeInsets.all(10),
                              title: e.displayValue,
                              value: model.currentUser?.pushNotiSetting
                                      ?.contains(e) ??
                                  false,
                              divider: true,
                              valueChanged: (value) {
                                if (value != null) {
                                  model.controller.updatePushNoti(e, value);
                                }
                              },
                            ))
                        .toList(),
                  ],
                );
              });
        },
      );
    });
  }
}
