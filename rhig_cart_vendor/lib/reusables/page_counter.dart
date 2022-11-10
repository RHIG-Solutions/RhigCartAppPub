import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/theme_controller.dart';

//Builds page counter. Defaulted to 4 pages, can override the default by sending
//a new page total.
Widget buildPageCounter({required pageNumber, totalPages = 4}) {
  return SizedBox(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= totalPages; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: kColourRHIGGrey, width: i == pageNumber ? 6 : 0),
                color: i == pageNumber ? Colors.white : kColourRHIGLightGrey,
              ),
            ),
          ),
      ],
    ),
  );
}
