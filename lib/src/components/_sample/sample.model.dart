part of '../index.dart';

class SampleModel extends MomentumModel<SampleController> {
  SampleModel(SampleController controller) : super(controller);

  @override
  void update() {
    SampleModel(
      controller,
    ).updateMomentum();
  }
}
