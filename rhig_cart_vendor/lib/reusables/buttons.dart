import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:rhig_cart_vendor/styles.dart';

SizedBox buildBottomButton(
    {required String label, required VoidCallback onPressed}) {
  return SizedBox(
    width: double.infinity,
    height: kButtonHeight,
    child: TextButton(
      onPressed: onPressed,
      child: Text(label),
      style: TextButton.styleFrom(
        backgroundColor: kRHIGDarkGreen,
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kInputRadius),
        ),
      ),
    ),
  );
}

TextButton buildTextButton({required String label, required onPressed}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      label,
      style: const TextStyle(color: kRHIGGrey, fontSize: 13),
    ),
  );
}
