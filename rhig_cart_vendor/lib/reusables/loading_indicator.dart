import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/theme_controller.dart';

Widget loadingIndicator({String label = ''}) {
  return Scaffold(
    body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              color: Color(myPrefs.dColourMain1),
            ),
          ),
          Text(
            label,
            style: myPrefs.dHeader3Main1Style,
          )
        ],
      ),
    ),
  );
}
