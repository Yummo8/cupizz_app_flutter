import 'dart:async';

import 'package:cupizz_app/src/base/base.dart';

import 'incoming_call.model.dart';

class IncomingCallController extends MomentumController<IncomingCallModel> {
  @override
  IncomingCallModel init() {
    return IncomingCallModel(
      this,
    );
  }

  Future onNewIncomingCall(Message call) async {
    if (model.currentIncomingCall != null) return;

    model.update(currentIncomingCall: call);
    unawaited(Get.toNamed(Routes.incomingCall));
    unawaited(15.delay().then((_) => _endRinging()));
  }

  Future acceptIncomingCall() async {
    if (model.currentIncomingCall != null) {
      await Get.find<MessageService>().acceptCall(model.currentIncomingCall.id);
    }
    _endRinging();
    // TODO navigate to in call screen
  }

  void endIncomingCall() {
    if (model.currentIncomingCall != null) {
      Get.find<MessageService>().endCall(model.currentIncomingCall.id);
    }
    _endRinging();
  }

  void _endRinging() {
    if (Get.currentRoute == Routes.incomingCall) {
      Get.back();
    }
    model.removeCurrentIncomingCall();
  }
}
