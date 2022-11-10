import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:rhig_cart_vendor/theme_controller.dart';

SizedBox buildBottomButton(
    {required String label,
    required VoidCallback onPressed,
    required PreferenceController myPrefs}) {
  return SizedBox(
    width: double.infinity,
    height: kButtonHeight,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Color(myPrefs.dColourMain1),
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kInputRadius),
        ),
      ),
      child: Text(label),
    ),
  );
}

TextButton buildTextButton({required String label, required onPressed}) {
  return TextButton(
    style: TextButton.styleFrom(
      primary: kColourRHIGGrey, // Text Color
    ),
    onPressed: onPressed,
    child: Text(
      label,
      style: const TextStyle(color: kColourRHIGGrey, fontSize: 13),
    ),
  );
}
