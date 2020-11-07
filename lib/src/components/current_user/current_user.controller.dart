import 'package:cupizz_app/src/services/index.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class CurrentUserController extends MomentumController<CurrentUserModel> {
  @override
  CurrentUserModel init() {
    return CurrentUserModel(
      this,
      currentUser: null,
    );
  }

  Future<void> getCurrentUser() async {
    final service = getService<UserService>();
    final result = await service.getCurrentUser();
    this.model.update(currentUser: result);
  }
}
