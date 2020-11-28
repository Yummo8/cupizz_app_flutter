part of '../index.dart';

class AnimationBuildLogin extends StatefulWidget {
  final Size size;
  final double yOffset;
  final Color color;

  AnimationBuildLogin({
    this.size,
    this.yOffset,
    this.color,
  });

  @override
  _AnimationBuildLoginState createState() => _AnimationBuildLoginState();
}

class _AnimationBuildLoginState extends State<AnimationBuildLogin>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> wavePoints = [];

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 5000))
          ..addListener(() {
            wavePoints.clear();

            final waveSpeed = animationController.value * 1080;
            final fullSphere = animationController.value * pi * 2;
            final normalizer = cos(fullSphere);
            final waveWidth = pi / 270;
            final waveHeight = 30.0;

            for (var i = 0; i <= widget.size.width.toInt(); ++i) {
              var calc = sin((waveSpeed - i) * waveWidth);
              wavePoints.add(
                Offset(
                  i.toDouble(), //X
                  calc * waveHeight * normalizer + widget.yOffset, //Y
                ),
              );
            }
          });

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return ClipPath(
          clipper: ClipperWidget(
            waveList: wavePoints,
          ),
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class ClipperWidget extends CustomClipper<Path> {
  final List<Offset> waveList;

  ClipperWidget({this.waveList});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addPolygon(waveList, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
