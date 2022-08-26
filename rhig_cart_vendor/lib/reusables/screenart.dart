import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'constants.dart';

//Set of constants specific to the screen art

int topArtSplitPercentage = 35; // Top color split percentage
double arcStart = 60; // How far up the box the arc should start

//Paints two tone grey background
BoxDecoration rHIGGreyBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: const [
      kRHIGBackLightGrey,
      kRHIGBackLightGrey,
      kRHIGBackDarkGrey,
      kRHIGBackDarkGrey
    ],
    stops: [0, topArtSplitPercentage / 100, topArtSplitPercentage / 100, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
);

//Paints Top Artwork for signup pages
Widget topArt() {
  return Stack(
    children: [
      Row(
        children: [
          Flexible(
            flex: topArtSplitPercentage,
            child: Container(color: kRHIGLightGreen),
          ),
          Flexible(
            flex: 100 - topArtSplitPercentage,
            child: Container(color: kRHIGDarkGreen),
          ),
        ],
      ),
      SizedBox(
          width: double.infinity,
          height: kTopArtHeight,
          child: CustomPaint(painter: CurvePainter())),
    ],
  );
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = kRHIGBackGround;

    var path = Path();
    path.moveTo(0, size.height - arcStart);
    path.quadraticBezierTo(size.width * 0.5, size.height + arcStart, size.width,
        size.height - arcStart);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
