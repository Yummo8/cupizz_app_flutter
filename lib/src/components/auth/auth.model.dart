part of '../index.dart';

class AuthModel extends MomentumModel<AuthController> {
  AuthModel(AuthController controller) : super(controller);

  @override
  void update() {
    AuthModel(controller).updateMomentum();
  }
}
