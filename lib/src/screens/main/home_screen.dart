library home_screen;

import '../../widgets/index.dart';
import 'package:flutter/material.dart' hide Router;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Container(
        child: Center(
          child: CustomPaint(
            size: Size(350,
                696), //You can Replace this with your desired WIDTH and HEIGHT
            painter: RPSCustomPainter(),
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path = Path();
    path.moveTo(size.width * 0.8, 0);
    path.quadraticBezierTo(
        size.width * 0.80, size.height * 0.10, size.width, size.height * 0.10);
    path.quadraticBezierTo(
        size.width * 1.00, size.height * 0.00, size.width, 0);
    path.lineTo(size.width * 0.80, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
