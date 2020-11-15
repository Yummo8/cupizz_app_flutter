part of '../index.dart';

class SampleModel extends MomentumModel<SampleController> {
  SampleModel(SampleController controller) : super(controller);

  @override
  void update() {
    SampleModel(
      controller,
    ).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return SampleModel(controller);
  }

  @override
  Map<String, dynamic> toJson() => {};
}
