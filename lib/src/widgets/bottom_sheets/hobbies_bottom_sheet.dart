import 'package:cupizz_app/src/base/base.dart';

class HobbiesBottomSheet {
  final Function(Hobby hobby) onItemClick;
  final Function onClose;

  HobbiesBottomSheet({
    this.onItemClick,
    this.onClose,
  });

  void show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return MomentumBuilder(
              controllers: [HobbyListController, CurrentUserController],
              builder: (context, snapshot) {
                final selectedHobbies =
                    snapshot<CurrentUserModel>().currentUser?.hobbies ?? [];
                final hobbyListModel = snapshot<HobbyListModel>();

                if (hobbyListModel.isLoading) {
                  return LoadingIndicator(padding: EdgeInsets.all(20));
                } else if (hobbyListModel.error.isExistAndNotEmpty) {
                  return ErrorIndicator(
                    moreErrorDetail: hobbyListModel.error,
                    onReload: () {
                      hobbyListModel.controller.loadHobbies();
                    },
                  );
                } else if (hobbyListModel.hobbies.isExistAndNotEmpty) {
                  return Container(
                    height: 400,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Wrap(
                        spacing: 10,
                        children: hobbyListModel.hobbies
                            .map(
                              (e) => HobbyItem(
                                  hobby: e,
                                  isSelected: selectedHobbies.contains(e)),
                            )
                            .toList(),
                      ),
                    ),
                  );
                } else {
                  return NotFoundIndicator(type: Strings.common.hobbies);
                }
              });
        });
  }
}
