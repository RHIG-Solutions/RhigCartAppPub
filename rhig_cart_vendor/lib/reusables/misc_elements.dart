import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';

//File for misc elements that are used across several screens.

//Builds Bottom "Sign in if you already have an account" row for signup pages
Row buildAlreadyHaveAccountRow(BuildContext context,
    {required PreferenceController myPrefs}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Already have an account?',
        style: TextStyle(color: Color(myPrefs.dColourMain1)),
      ),
      buildTextButton(
          label: 'Sign In',
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          })
    ],
  );
}

//Builds Bottom "Return to login page" row for password recovery
Row buildReturnToLoginRow(BuildContext context,
    {required PreferenceController myPrefs}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Return to',
        style: TextStyle(color: Color(myPrefs.dColourMain1)),
      ),
      buildTextButton(
          label: 'Login',
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          })
    ],
  );
}
