import '../../base/base.dart';
import '../answer_question/edit_answer_screen.dart';

part 'components/edit_user_images_screen.controller.dart';
part 'components/edit_user_images_screen.model.dart';

class EditUserImagesScreenParams extends RouterParam {
  final UserImage focusItem;

  EditUserImagesScreenParams(this.focusItem);
}

class EditUserImagesScreen extends StatefulWidget {
  @override
  _EditUserImagesScreenState createState() => _EditUserImagesScreenState();
}

class _EditUserImagesScreenState extends State<EditUserImagesScreen>
    with KeepScrollOffsetMixin {
  static double lastScrollOffset = 0;
  final focusItemKey = GlobalKey();
  UserImage forcusItem;

  @override
  double get lastOffset => lastScrollOffset;

  @override
  set lastOffset(double value) {
    lastScrollOffset = value;
  }

  bool isEdit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final params = Router.getParam<EditUserImagesScreenParams>(context);
      if (params?.focusItem != null) {
        setState(() {
          forcusItem = params.focusItem;
        });
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Scrollable.ensureVisible(focusItemKey.currentContext,
              duration: Duration(milliseconds: 500));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeHelper = SizeHelper(context);

    return MomentumBuilder(
        controllers: [CurrentUserController, EditUserImagesScreenController],
        builder: (context, snapshot) {
          final userModel = snapshot<CurrentUserModel>();
          final model = snapshot<EditUserImagesScreenModel>();

          return PrimaryScaffold(
            isLoading: userModel.isDeletingImage,
            appBar: BackAppBar(
              title: 'Ảnh',
              actions: model.newOrderList.isExistAndNotEmpty &&
                      model.newOrderList != userModel.currentUser.userImages
                  ? [
                      SaveButtonAsync(
                        onPressed: () async {
                          await userModel.controller
                              .updateUserImagesOrder(model.newOrderList);
                          model.controller.reset();
                          Router.pop(context);
                        },
                      )
                    ]
                  : null,
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
                      onReorder: model.controller.changeOrder,
                      scrollDirection: Axis.vertical,
                      scrollController: scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      children: (model.newOrderList.isExistAndNotEmpty
                              ? model.newOrderList
                              : userModel.currentUser.userImages)
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
    return IntrinsicHeight(
      key: forcusItem?.id == userImage.id ? focusItemKey : Key(userImage.id),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          Expanded(child: CartImage(readOnly: true, userImage: userImage)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (userImage.answer != null)
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Router.goto(context, EditAnswerScreen,
                        params: EditAnswerScreenParams(userImage));
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
      ),
    );
  }
}
