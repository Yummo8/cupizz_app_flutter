import 'dart:ui';

import 'package:cupizz_app/src/base/base.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class InComingCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: MomentumBuilder(
          controllers: [IncomingCallController],
          builder: (context, snapshot) {
            final model = snapshot<IncomingCallModel>();

            return Stack(
              children: [
                Positioned.fill(
                  child: CustomNetworkImage(
                    model.currentIncomingCall?.sender?.avatar?.url,
                    isAvatar: true,
                  ),
                ),
                Positioned.fill(
                  child: Container(color: Colors.black54),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 25,
                    sigmaY: 25,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            Text(
                              model.currentIncomingCall?.sender?.nickName ?? '',
                              style: const TextStyle(
                                fontSize: 42,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleCallButton(
                              onPressed: model.controller.endIncomingCall,
                              icon: Icons.call_end,
                              backgroundColor: Colors.red,
                              title: 'Từ chối',
                            ),
                            CircleCallButton(
                              onPressed: () async {
                                await Permission.microphone.request();
                                await Permission.camera.request();
                                final status =
                                    await Permission.microphone.status;
                                if (status.isUndetermined) {
                                  PhotoManager.openSetting();
                                }
                                if (model.currentIncomingCall.roomId != null) {
                                  // TODO accept call
                                }
                              },
                              icon: Icons.call,
                              backgroundColor: Colors.green,
                              title: 'Chấp nhận',
                            ),
                          ],
                        ),
                      ],
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
    Key key,
    this.onPressed,
    this.backgroundColor,
    this.icon,
    this.title,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData icon;
  final String title;

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
          Text(widget.title, style: const TextStyle(color: Colors.white))
      ],
    );
  }
}
