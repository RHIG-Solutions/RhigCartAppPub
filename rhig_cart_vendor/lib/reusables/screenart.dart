import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';
import '../constants.dart';

//Set of constants specific to the screen art

int topArtSplitPercentage = 35; // Top color split percentage
double arcStart = 60; // How far up the box the arc should start

//Paints two tone grey background
BoxDecoration rHIGGreyBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: const [
      kColourRHIGBackLightGrey,
      kColourRHIGBackLightGrey,
      kColourRHIGBackDarkGrey,
      kColourRHIGBackDarkGrey
    ],
    stops: [0, topArtSplitPercentage / 100, topArtSplitPercentage / 100, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
);

//Paints Top Artwork for signup pages
Widget topArt({required PreferenceController myPrefs}) {
  return Stack(
    children: [
      Row(
        children: [
          Flexible(
            flex: topArtSplitPercentage,
            child: Container(color: Color(myPrefs.dColourMain2)),
          ),
          Flexible(
            flex: 100 - topArtSplitPercentage,
            child: Container(color: Color(myPrefs.dColourMain1)),
          ),
        ],
      ),
      SizedBox(
          width: double.infinity,
          height: kTopArtHeight,
          child: CustomPaint(
              painter: CurvePainter(colour: myPrefs.dColourBackground))),
    ],
  );
}

class CurvePainter extends CustomPainter {
  late final int colour;
  CurvePainter({required this.colour});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(colour);

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
