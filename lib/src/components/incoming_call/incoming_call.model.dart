import 'package:cupizz_app/src/base/base.dart';

import 'incoming_call.controller.dart';

class IncomingCallModel extends MomentumModel<IncomingCallController> {
  IncomingCallModel(IncomingCallController controller,
      {this.currentIncomingCall, this.currentCall})
      : super(controller);

  final Message currentIncomingCall;
  final Message currentCall;

  @override
  void update({Message currentIncomingCall, Message currentCall}) {
    IncomingCallModel(
      controller,
      currentIncomingCall: currentIncomingCall ?? this.currentIncomingCall,
      currentCall: currentCall ?? this.currentCall,
    ).updateMomentum();
  }

  void removeCurrentIncomingCall() {
    IncomingCallModel(controller, currentCall: currentCall).updateMomentum();
  }

  void removeCurrentCall() {
    IncomingCallModel(controller, currentIncomingCall: currentIncomingCall)
        .updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return IncomingCallModel(controller);
  }

  @override
  Map<String, dynamic> toJson() => {};
}
