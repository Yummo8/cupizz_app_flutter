import 'package:cupizz_app/src/screens/answer_question/answer_question_screen.dart';

import '../../base/base.dart';

part 'components/edit_user_images_screen.controller.dart';
part 'components/edit_user_images_screen.model.dart';

class EditUserImagesScreen extends StatefulWidget {
  @override
  _EditUserImagesScreenState createState() => _EditUserImagesScreenState();
}

class _EditUserImagesScreenState extends State<EditUserImagesScreen>
    with KeepScrollOffsetMixin {
  static double lastScrollOffset = 0;
  @override
  double get lastOffset => lastScrollOffset;

  @override
  set lastOffset(double value) {
    lastScrollOffset = value;
  }

  bool isEdit;

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeHelper = SizeHelper(context);

    return MomentumBuilder(
        controllers: [CurrentUserController],
        builder: (context, snapshot) {
          final model = snapshot<CurrentUserModel>();
          return PrimaryScaffold(
            isLoading: model.isDeletingImage,
            appBar: BackAppBar(
              title: 'Ảnh',
              actions: [SaveButton()],
            ),
            body: Container(
              child: Column(
                children: [
                  SizedBox(height: sizeHelper.rW(5)),
                  Text(
                    'Kéo rồi thả ảnh để thay đổi thứ tự trên hồ sơ của bạn',
                    style: context.textTheme.bodyText1,
                  ),
                  SizedBox(height: sizeHelper.rW(5)),
                  Expanded(
                    child: ReorderableListView(
                      onReorder: _onReorder,
                      scrollDirection: Axis.vertical,
                      scrollController: scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      children: model.currentUser.userImages
                          .map((e) => _buildListTile(context, e))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _buildListTile(BuildContext context, UserImage userImage) {
    return Row(
      key: Key(userImage.id),
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        Expanded(child: CartImage(readOnly: true, userImage: userImage)),
        Column(
          children: [
            if (userImage.answer != null)
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Router.goto(context, AnswerQuestionScreen,
                      params: AnswerQuestionScreenParams(userImage: userImage));
                },
              ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Momentum.controller<CurrentUserController>(context)
                    .removeUserImage(userImage);
              },
            ),
          ],
        )
      ],
    );
  }
}
