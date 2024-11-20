import 'package:flutter/material.dart';

class SShapeClipper extends CustomClipper<Path> {
  @override
 Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height); // Start at bottom left

    // Define the curve using cubic Bezier curve
    path.cubicTo(size.width / 3, size.height - 50, 2 * size.width / 3,
        size.height + 30, size.width, size.height - 20);

    path.lineTo(size.width, 0); // Line to top right
    path.lineTo(0, 0); // Line to top left
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) =>
      false; // Optimizes performance
}
