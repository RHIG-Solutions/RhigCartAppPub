import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/constants.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';

Future<void> showDeleteDialog(BuildContext context,
    {required List<Text> messages, required List<Button> buttons}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        buttonPadding: const EdgeInsets.all(0),
        content: ListView(
          shrinkWrap: true,
          children: [
            const Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
              size: 50,
            ),
            for (int index = 0; index < messages.length; index++)
              messages[index],
          ],
        ),
        actions: [
          Container(
            decoration: const BoxDecoration(
              color: kColourRHIGLightGrey,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(kSpacerStore),
              child: buildBottomButtonRow(
                buttons: [
                  for (int index = 0; index < buttons.length; index++)
                    buttons[index]
                ],
              ),
            ),
          )
        ],
      );
    },
  );
}

Future<void> showConfirmDialog(BuildContext context,
    {required List<Text> messages, required List<Button> buttons}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        buttonPadding: const EdgeInsets.all(0),
        content: ListView(
          shrinkWrap: true,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 50,
            ),
            for (int index = 0; index < messages.length; index++)
              messages[index],
          ],
        ),
        actions: [
          Container(
            decoration: const BoxDecoration(
              color: kColourRHIGLightGrey,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(kSpacerStore),
              child: buildBottomButtonRow(
                buttons: [
                  for (int index = 0; index < buttons.length; index++)
                    buttons[index]
                ],
              ),
            ),
          )
        ],
      );
    },
  );
}
