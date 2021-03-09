import 'package:cupizz_app/src/base/base.dart';

class StarCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path();
    path_0.moveTo(size.width * 0.9764033, size.height * 0.3676900);
    path_0.lineTo(size.width * 0.6525000, size.height * 0.3376500);
    path_0.lineTo(size.width * 0.5238367, size.height * 0.03888333);
    path_0.cubicTo(
        size.width * 0.5148300,
        size.height * 0.01796340,
        size.width * 0.4851667,
        size.height * 0.01796340,
        size.width * 0.4761600,
        size.height * 0.03888333);
    path_0.lineTo(size.width * 0.3474967, size.height * 0.3376533);
    path_0.lineTo(size.width * 0.02359373, size.height * 0.3676900);
    path_0.cubicTo(
        size.width * 0.0009141033,
        size.height * 0.3697933,
        size.width * -0.008251900,
        size.height * 0.3980033,
        size.width * 0.008859400,
        size.height * 0.4130333);
    path_0.lineTo(size.width * 0.2532457, size.height * 0.6277267);
    path_0.lineTo(size.width * 0.1817263, size.height * 0.9450600);
    path_0.cubicTo(
        size.width * 0.1767183,
        size.height * 0.9672800,
        size.width * 0.2007143,
        size.height * 0.9847133,
        size.width * 0.2202983,
        size.height * 0.9730833);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.8070033);
    path_0.lineTo(size.width * 0.7797000, size.height * 0.9730833);
    path_0.cubicTo(
        size.width * 0.7992833,
        size.height * 0.9847133,
        size.width * 0.8232800,
        size.height * 0.9672800,
        size.width * 0.8182733,
        size.height * 0.9450600);
    path_0.lineTo(size.width * 0.7467533, size.height * 0.6277267);
    path_0.lineTo(size.width * 0.9911400, size.height * 0.4130333);
    path_0.cubicTo(
        size.width * 1.008250,
        size.height * 0.3980033,
        size.width * 0.9990833,
        size.height * 0.3697933,
        size.width * 0.9764033,
        size.height * 0.3676900);
    path_0.close();

    final paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffFFDC64).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    final path_1 = Path();
    path_1.moveTo(size.width * 0.5238367, size.height * 0.03888333);
    path_1.cubicTo(
        size.width * 0.5148300,
        size.height * 0.01796340,
        size.width * 0.4851667,
        size.height * 0.01796340,
        size.width * 0.4761600,
        size.height * 0.03888333);
    path_1.lineTo(size.width * 0.3474967, size.height * 0.3376533);
    path_1.lineTo(size.width * 0.02359373, size.height * 0.3676900);
    path_1.cubicTo(
        size.width * 0.0009141033,
        size.height * 0.3697933,
        size.width * -0.008251900,
        size.height * 0.3980033,
        size.width * 0.008859400,
        size.height * 0.4130333);
    path_1.lineTo(size.width * 0.2532457, size.height * 0.6277267);
    path_1.lineTo(size.width * 0.1817263, size.height * 0.9450600);
    path_1.cubicTo(
        size.width * 0.1767183,
        size.height * 0.9672800,
        size.width * 0.2007143,
        size.height * 0.9847133,
        size.width * 0.2202983,
        size.height * 0.9730833);
    path_1.lineTo(size.width * 0.2827260, size.height * 0.9360167);
    path_1.cubicTo(
        size.width * 0.2913667,
        size.height * 0.5803500,
        size.width * 0.4566200,
        size.height * 0.3298887,
        size.width * 0.5874567,
        size.height * 0.1866097);
    path_1.lineTo(size.width * 0.5238367, size.height * 0.03888333);
    path_1.close();

    final paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xffFFC850).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
