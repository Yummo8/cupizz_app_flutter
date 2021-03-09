import 'dart:ui';

import 'package:cupizz_app/src/base/base.dart';

class InComingCallScreenArgs {
  final String? avatar;
  final String? name;

  InComingCallScreenArgs({required this.avatar, required this.name});
}

class InComingCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as InComingCallScreenArgs?;
    return PrimaryScaffold(
      body: MomentumBuilder(
          controllers: [CallController],
          builder: (context, snapshot) {
            final model = snapshot<CallModel>()!;
            final avatar =
                args?.avatar ?? model.currentIncomingCall?.sender?.avatar?.url;
            final name =
                args?.name ?? model.currentIncomingCall?.sender?.nickName ?? '';

            return Stack(
              children: [
                Positioned.fill(
                  child: CustomNetworkImage(avatar, isAvatar: true),
                ),
                Positioned.fill(
                  child: Container(color: Colors.black54),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 25,
                      sigmaY: 25,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 42,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleCallButton(
                                onPressed: model.controller.endCall,
                                icon: Icons.call_end,
                                backgroundColor: Colors.red,
                                title: model.currentIncomingCall != null
                                    ? 'Từ chối'
                                    : '',
                              ),
                              if (model.currentIncomingCall != null) ...[
                                Expanded(child: const SizedBox.shrink()),
                                CircleCallButton(
                                  onPressed: () async {
                                    if (model.currentIncomingCall!.roomId !=
                                        null) {
                                      await model.controller
                                          .acceptIncomingCall();
                                    }
                                  },
                                  icon: Icons.call,
                                  backgroundColor: Colors.green,
                                  title: 'Chấp nhận',
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CircleCallButton extends StatefulWidget {
  const CircleCallButton({
    Key? key,
    this.onPressed,
    this.backgroundColor,
    this.icon,
    this.title,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final IconData? icon;
  final String? title;

  @override
  _CircleCallButtonState createState() => _CircleCallButtonState();
}

class _CircleCallButtonState extends State<CircleCallButton> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 3,
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: widget.backgroundColor,
          radius: 32,
          child: IconButton(
            icon: Icon(
              widget.icon,
              size: 32,
            ),
            onPressed: widget.onPressed,
          ),
        ),
        if (widget.title != null)
          Text(widget.title!, style: const TextStyle(color: Colors.white))
      ],
    );
  }
}
