part of '../user_profile.dart';

class BackgroudClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    var height = size.height * 0.8;
    path.lineTo(0, height);

    var firstControlPoint = Offset(size.width / 5, height);
    var firstEndPoint = Offset(size.width / 5 * 2, height + 20);

    var secondControlPoint = Offset(size.width - (size.width / 4), height + 60);
    var secondEndPoint = Offset(size.width, height + 10);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class PinkOneClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    var height = size.height / 10 * 6;

    path.lineTo(0, height);

    var firstControlPoint = Offset(size.width / 5, height + 40);
    var firstEndPoint = Offset(size.width / 5 * 2, height + 60);

    var secondControlPoint =
        Offset(size.width - (size.width / 4), height + 100);
    var secondEndPoint = Offset(size.width, height + 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class PinkTwoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    var height = size.height / 10 * 6;
    path.lineTo(0, height + 40);

    var firstControlPoint = Offset(size.width / 5, height + 80);
    var firstEndPoint = Offset(size.width / 5 * 2, height + 60);

    var secondControlPoint = Offset(size.width - (size.width / 4), height + 20);
    var secondEndPoint = Offset(size.width, height - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 10 * 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
