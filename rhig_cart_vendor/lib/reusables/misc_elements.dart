import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';

//Builds Bottom "Sign in if you already have an account" row for signup pages
Row buildAlreadyHaveAccountRow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'Already have an account?',
        style: TextStyle(color: kRHIGDarkGreen),
      ),
      buildTextButton(
          label: 'Sign In',
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          })
    ],
  );
}
