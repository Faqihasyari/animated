// app/modules/utils/widgets/curved_clipper.dart
import 'package:flutter/material.dart';

class CurvedClipper extends CustomClipper<Path> {
  final double curveHeight;

  CurvedClipper({this.curveHeight = 30});

  @override
  Path getClip(Size size) {
    final path = Path();
    
    path.moveTo(0, curveHeight);
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      curveHeight,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}