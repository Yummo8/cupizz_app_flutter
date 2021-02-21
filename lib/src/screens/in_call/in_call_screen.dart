import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cupizz_app/src/base/base.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;

class InCallScreen extends StatefulWidget {
  @override
  _InCallScreenState createState() => _InCallScreenState();
}

class _InCallScreenState extends State<InCallScreen> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  RtcEngine _engine;

  @override
  void dispose() {
    _users.clear();
    _engine?.leaveChannel();
    _engine?.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initialize();
    });
  }

  Future<void> initialize() async {
    final appId =
        await Momentum.controller<SystemController>(context).getAgoraAppId();
    final callMessage =
        Momentum.controller<CallController>(context).model.currentCall;

    if (!appId.isExistAndNotEmpty) {
      setState(() {
        _infoStrings.add('App ID missing, please check server side enviroment');
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    } else if (callMessage == null) {
      setState(() {
        _infoStrings.add('Missing call message');
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    } else if (!callMessage.agoraToken.isExistAndNotEmpty) {
      setState(() {
        _infoStrings.add('Call message is missing token');
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    } else if (!callMessage.roomId.isExistAndNotEmpty) {
      setState(() {
        _infoStrings.add('Call message is missing room id');
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine(appId);
    _addAgoraEventHandlers();
    // await _engine.enableWebSdkInteroperability(true);
    var configuration = VideoEncoderConfiguration();
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(
        callMessage.agoraToken, callMessage.roomId, null, 0);
  }

  Future<void> _initAgoraRtcEngine(String appId) async {
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  List<Widget> _getRenderViews() {
    final list = <StatefulWidget>[];
    // if (widget.role == ClientRole.Broadcaster) {
    //   list.add(rtc_local_view.SurfaceView());
    // }
    _users
        .forEach((int uid) => list.add(rtc_remote_view.SurfaceView(uid: uid)));
    list.add(rtc_local_view.SurfaceView(key: UniqueKey()));
    return list;
  }

  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  Widget _viewRows(List<Widget> views) {
    var video = Container();
    final local = views.removeLast();
    switch (views.length) {
      case 1:
        video = Container(
            child: Column(
          children: <Widget>[_videoView(views.last)],
        ));
        break;
      case 2:
        video = Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        ));
        break;
      case 3:
        video = Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
        break;
      case 4:
        video = Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
        break;
      default:
    }

    return Stack(
      children: [
        video,
        Positioned(
          right: 20,
          top: 20,
          child: SafeArea(
            child: SizedBox(
              width: Get.width * 0.25,
              height: Get.height * 0.20,
              child: Container(
                  child: Column(
                children: <Widget>[_videoView(local)],
              )),
            ),
          ),
        ),
      ],
    );
  }

  Widget _toolbar() {
    // if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Momentum.controller<CallController>(context).endCall();
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(child: _viewRows(_getRenderViews())),
            if (AppConfig.instance.isDev) _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
