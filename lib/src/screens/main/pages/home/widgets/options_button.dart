part of '../home_page.dart';

class OptionsButton extends StatelessWidget {
  final Function onPressed;

  const OptionsButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.all(10),
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.onPrimary.withOpacity(0.2),
        ),
        child: Icon(
          Icons.tune,
          color: context.colorScheme.onPrimary,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  final Color color;

  RPSCustomPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.cubicTo(0, size.height * 0.6, size.width * 0.7, size.height,
        size.width, size.height);
    path_0.quadraticBezierTo(0, size.height, size.width, size.height);
    path_0.close();

    canvas.drawShadow(path_0, Colors.grey[900], 10.0, false);
    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
