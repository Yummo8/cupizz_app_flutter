import 'package:cupizz_app/src/base/base.dart';

import 'incoming_call.controller.dart';

class IncomingCallModel extends MomentumModel<IncomingCallController> {
  IncomingCallModel(IncomingCallController controller,
      {this.currentIncomingCall})
      : super(controller);

  final Message currentIncomingCall;

  @override
  void update({Message currentIncomingCall}) {
    IncomingCallModel(controller,
            currentIncomingCall:
                currentIncomingCall ?? this.currentIncomingCall)
        .updateMomentum();
  }

  void removeCurrentIncomingCall() {
    IncomingCallModel(controller).updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return IncomingCallModel(controller);
  }

  @override
  Map<String, dynamic> toJson() => {};
}
