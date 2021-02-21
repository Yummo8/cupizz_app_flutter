import 'package:cupizz_app/src/base/base.dart';

import 'call.controller.dart';

class CallModel extends MomentumModel<CallController> {
  CallModel(CallController controller,
      {this.currentIncomingCall, this.currentCall})
      : super(controller);

  final Message currentIncomingCall;
  final Message currentCall;

  @override
  void update({Message currentIncomingCall, Message currentCall}) {
    CallModel(
      controller,
      currentIncomingCall: currentIncomingCall ?? this.currentIncomingCall,
      currentCall: currentCall ?? this.currentCall,
    ).updateMomentum();
  }

  void removeCurrentIncomingCall() {
    CallModel(controller, currentCall: currentCall).updateMomentum();
  }

  void removeCurrentCall() {
    CallModel(controller, currentIncomingCall: currentIncomingCall)
        .updateMomentum();
  }

  @override
  MomentumModel<MomentumController> fromJson(Map<String, dynamic> json) {
    return CallModel(controller);
  }

  @override
  Map<String, dynamic> toJson() => {};
}
