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
                IconButton(
                    icon: Icon(
                      CupertinoIcons.ellipsis,
                      color: context.colorScheme.onBackground,
                    ),
                    onPressed: () {}),
              ],
            ),
            body: model.isFinding
                ? _Loading()
                : model.conversation != null
                    ? _Chat()
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

class _Chat extends StatelessWidget {
  const _Chat({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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
