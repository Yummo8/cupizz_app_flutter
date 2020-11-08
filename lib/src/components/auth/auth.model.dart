part of '../index.dart';

class AuthModel extends MomentumModel<AuthController> with EquatableMixin {
  AuthModel(AuthController controller, {this.token}) : super(controller);

  final String token;

  @override
  void update({String token}) {
    AuthModel(controller, token: token).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return AuthModel(controller, token: json['token']);
  }

  @override
  List<Object> get props => [token];
}
