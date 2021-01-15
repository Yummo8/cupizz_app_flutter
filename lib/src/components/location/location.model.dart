import 'package:cupizz_app/src/base/base.dart';

import 'location.controller.dart';

class LocationModel extends MomentumModel<LocationController> {
  LocationModel(LocationController controller) : super(controller);

  @override
  void update() {
    LocationModel(
      controller,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return LocationModel(controller);
  }

  @override
  Map<String, dynamic> toJson() => {};
}
