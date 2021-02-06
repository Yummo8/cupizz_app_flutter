import 'package:cupizz_app/src/base/base.dart';

import 'post_page.model.dart';

class PostPageController extends MomentumController<PostPageModel> {
  @override
  PostPageModel init() {
    return PostPageModel(
      this,
    );
  }
}
