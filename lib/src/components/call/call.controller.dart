import 'dart:async';

import 'package:cupizz_app/src/base/base.dart';

import 'call.model.dart';

class CallController extends MomentumController<CallModel> {
  StreamSubscription callSubscription;

  @override
  CallModel init() {
    return CallModel(
      this,
    );
  }

  void call({Conversation conversation, ChatUser user}) {
    assert(conversation != null || user != null);
    callSubscription = Get.find<MessageService>()
        .call(
      ConversationKey(
        conversationId: conversation?.id,
        targetUserId: user?.id,
      ),
    )
        .listen((callMessage) {
      model.update(currentCall: callMessage);

      if (callMessage.callStatus == CallStatus.missing ||
          callMessage.callStatus == CallStatus.rejected) {
        callSubscription.cancel();
      } else if (callMessage.callStatus == CallStatus.ringing) {
        Get.toNamed(Routes.incomingCall,
            arguments: InComingCallScreenArgs(
              avatar: conversation?.images?.first?.url ?? user?.avatar?.url,
              name: conversation?.name ?? user?.nickName,
            ));
      } else if (callMessage.callStatus == CallStatus.inCall) {
        Get.offNamed(Routes.inCall);
      } else if (callMessage.callStatus == CallStatus.ended) {
        endCall();
      }
    });
  }

  Future onNewIncomingCall(Message call) async {
    if (model.currentIncomingCall != null) return;

    model.update(currentIncomingCall: call);
    unawaited(Get.toNamed(Routes.incomingCall));
  }

  void onNewMissingCall(Message call) {
    if (model.currentIncomingCall?.id != call?.id &&
        model.currentCall?.id != call?.id) return;
    endCall();
  }

  Future acceptIncomingCall() async {
    if (model.currentIncomingCall != null) {
      await Get.find<MessageService>().acceptCall(model.currentIncomingCall.id);
    }
    model.update(currentCall: model.currentIncomingCall);
    model.removeCurrentIncomingCall();
    unawaited(Get.offNamed(Routes.inCall));
  }

  void endCall() {
    final call = model.currentIncomingCall ?? model.currentCall;
    if (call != null) {
      Get.find<MessageService>().endCall(call.id);
    }
    _endCall();
  }

  void _endCall() {
    if (Get.currentRoute == Routes.inCall ||
        Get.currentRoute == Routes.incomingCall) {
      Get.back();
    }
    callSubscription?.cancel();
    model.removeCurrentCall();
    model.removeCurrentIncomingCall();
  }
}
