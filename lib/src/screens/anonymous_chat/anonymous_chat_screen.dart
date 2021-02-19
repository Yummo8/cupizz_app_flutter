import 'package:cupizz_app/src/base/base.dart';

class AnonymousChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
        controllers: [AnonymousChatController],
        builder: (context, snapshot) {
          final model = snapshot<AnonymousChatModel>();
          return PrimaryScaffold(
            appBar: BackAppBar(
              title: 'Trò chuyện ẩn danh',
              actions: [
                if (model.conversation != null || model.isFinding)
                  IconButton(
                      icon: Icon(
                        CupertinoIcons.ellipsis,
                        color: context.colorScheme.onBackground,
                      ),
                      onPressed: () {
                        Menu([
                          if (model.isFinding) ...[
                            MenuItem(
                              title: 'Dừng tìm kiếm',
                              onPressed: () {
                                model.controller.cancelFinding();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                          if (model.conversation != null) ...[
                            MenuItem(
                              title: 'Xin info',
                              onPressed: () {
                                Fluttertoast.showToast(
                                    msg: Strings.common.inDeveloping);
                              },
                            ),
                            MenuItem(
                              title: 'Ngưng trò chuyện',
                              isDestructiveAction: true,
                              onPressed: () {
                                model.controller.deleteAnonymousChat();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ]).show(context);
                      }),
              ],
            ),
            bottomNavigationBar: MomentumBuilder(
                controllers: [CurrentUserController],
                builder: (context, snapshot) {
                  final model = snapshot<CurrentUserModel>();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Transform.scale(
                      scale: 0.8,
                      child: CheckboxListTile(
                          title: Text(NotificationType
                                  .otherFindingAnonymousChat.title ??
                              ''),
                          value: model.currentUser?.pushNotiSetting?.contains(
                                  NotificationType.otherFindingAnonymousChat) ??
                              false,
                          onChanged: (value) {
                            if (value != null) {
                              model.controller.updatePushNoti(
                                  NotificationType.otherFindingAnonymousChat,
                                  value);
                            }
                          }),
                    ),
                  );
                }),
            body: model.isFinding
                ? _Loading()
                : model.conversation != null
                    ? MomentumBuilder(
                        controllers: [MessagesScreenController],
                        builder: (context, snapshot) {
                          final messagesModel = snapshot<MessagesScreenModel>();
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            final args = MessagesScreenParams(
                                conversation: model.conversation);
                            if (args != null) {
                              messagesModel.controller.loadData(args);
                            }
                          });
                          return MessagesScreenWidget(model: messagesModel);
                        })
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Column(
                              children: [
                                Text(
                                  '''Trò chuyện ẩn danh là nơi giúp bạn tìm kiếm một người lạ để tâm sự, chia sẻ.''',
                                  style: context.textTheme.subtitle1.copyWith(
                                      color: context.colorScheme.onSurface),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '''Chúng tôi sẽ đảm bảo không để lộ danh tính của bạn cũng như đối phương khi chưa được phép.''',
                                  style: context.textTheme.caption.copyWith(
                                      color: context.colorScheme.onSurface,
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          OptionButton(
                            title: 'Bắt đầu',
                            isSelected: true,
                            onPressed: () {
                              model.controller.findAnonymousChat();
                            },
                          ),
                        ],
                      ),
          );
        });
  }
}

class _Loading extends StatelessWidget {
  const _Loading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: LoadingIndicator());
  }
}
