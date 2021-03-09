import 'package:cupizz_app/src/base/base.dart';

class DislikeUserCustomPainter extends CustomPainter {
  final Color color;

  DislikeUserCustomPainter({this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path();
    path_0.moveTo(size.width * 0.4350000, size.height * 0.2055556);
    path_0.arcToPoint(Offset(size.width * 0.3407222, size.height * 0.2446111),
        radius:
            Radius.elliptical(size.width * 0.1333333, size.height * 0.1333333),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path_0.arcToPoint(Offset(size.width * 0.4350000, size.height * 0.2055556),
        radius:
            Radius.elliptical(size.width * 0.1324333, size.height * 0.1324333),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.moveTo(size.width * 0.4350000, size.height * 0.1611111);
    path_0.arcToPoint(Offset(size.width * 0.6127778, size.height * 0.3388889),
        radius:
            Radius.elliptical(size.width * 0.1777778, size.height * 0.1777778),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_0.arcToPoint(Offset(size.width * 0.4350000, size.height * 0.1611111),
        radius:
            Radius.elliptical(size.width * 0.1777778, size.height * 0.1777778),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.close();

    final paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color;
    canvas.drawPath(path_0, paint_0_fill);

    final path_1 = Path();
    path_1.moveTo(size.width * 0.4350000, size.height * 0.6044444);
    path_1.arcToPoint(Offset(size.width * 0.5460333, size.height * 0.6256889),
        radius:
            Radius.elliptical(size.width * 0.2966667, size.height * 0.2966667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6361778, size.height * 0.6833333),
        radius:
            Radius.elliptical(size.width * 0.2841000, size.height * 0.2841000),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6964222, size.height * 0.7680778),
        radius:
            Radius.elliptical(size.width * 0.2655556, size.height * 0.2655556),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.7144444, size.height * 0.8266667),
        radius:
            Radius.elliptical(size.width * 0.2518667, size.height * 0.2518667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.1555556, size.height * 0.8266667);
    path_1.arcToPoint(Offset(size.width * 0.1735667, size.height * 0.7681000),
        radius:
            Radius.elliptical(size.width * 0.2518667, size.height * 0.2518667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.2338222, size.height * 0.6833333),
        radius:
            Radius.elliptical(size.width * 0.2655556, size.height * 0.2655556),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.3239667, size.height * 0.6256667),
        radius:
            Radius.elliptical(size.width * 0.2841000, size.height * 0.2841000),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.4350000, size.height * 0.6044444),
        radius:
            Radius.elliptical(size.width * 0.2966667, size.height * 0.2966667),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.moveTo(size.width * 0.4350000, size.height * 0.5600000);
    path_1.cubicTo(
        size.width * 0.2539778,
        size.height * 0.5600000,
        size.width * 0.1072222,
        size.height * 0.6992889,
        size.width * 0.1072222,
        size.height * 0.8711111);
    path_1.lineTo(size.width * 0.7627778, size.height * 0.8711111);
    path_1.cubicTo(
        size.width * 0.7627778,
        size.height * 0.6992889,
        size.width * 0.6160222,
        size.height * 0.5600000,
        size.width * 0.4350000,
        size.height * 0.5600000);
    path_1.close();

    final paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color;
    canvas.drawPath(path_1, paint_1_fill);

    final paint_2_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04444444;
    paint_2_stroke.color = color;
    canvas.drawLine(
        Offset(size.width * 0.7047222, size.height * 0.1592111),
        Offset(size.width * 0.8618556, size.height * 0.3163444),
        paint_2_stroke);

    final paint_3_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04444444;
    paint_3_stroke.color = color;
    canvas.drawLine(
        Offset(size.width * 0.8618556, size.height * 0.1592111),
        Offset(size.width * 0.7047222, size.height * 0.3163444),
        paint_3_stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
