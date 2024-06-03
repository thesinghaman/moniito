import 'package:flutter/material.dart';

/// Custom clipper for creating a path with curved edges.
class ACustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    // Define the first quadratic bezier curve
    final firstCurve = Offset(0, size.height - 30);
    final lastCurve = Offset(40, size.height - 30);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    // Define the second quadratic bezier curve
    final secondFirstCurve = Offset(0, size.height - 30);
    final secondLastCurve = Offset(size.width - 40, size.height - 30);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy,
        secondLastCurve.dx, secondLastCurve.dy);

    // Define the third quadratic bezier curve
    final thirdFirstCurve = Offset(size.width, size.height - 30);
    final thirdLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy,
        thirdLastCurve.dx, thirdLastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Always reclip to update the path when needed
    return true;
  }
}
