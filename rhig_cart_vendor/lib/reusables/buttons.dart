import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';

// Builds standard  button at bottom of screen
SizedBox buildBottomButton(
    {required String label, required VoidCallback onPressed}) {
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

// Builds standard text button
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

// Builds row of buttons at screen bottom, three types of buttons can be sent in
// List format, standard text label, icon buttons, and spacers.
Widget buildBottomButtonRow({required List<Button> buttons}) {
  return Row(
    children: [
      for (int index = 0; index < buttons.length; index++)
        buttons[index].spacer
            ? SizedBox(
                width: kSpacerStore,
              )
            : Expanded(
                flex: buttons[index].flex,
                child: SizedBox(
                  height: kButtonHeight,
                  child: TextButton(
                    onPressed: buttons[index].onPressed,
                    style: TextButton.styleFrom(
                      backgroundColor: buttons[index].colour,
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kInputRadius),
                      ),
                    ),
                    child: buttons[index].label != ''
                        ? Text(buttons[index].label)
                        : buttons[index].icon,
                  ),
                ),
              ),
    ],
  );
}

// class for transferring button specific data
class Button {
  String label = '';
  late VoidCallback onPressed;
  late Color colour;
  Icon icon = const Icon(null);
  int flex = 1;
  bool spacer = false;

  // Constructor for normal text button data
  Button(
      {this.label = '',
      required this.onPressed,
      required this.colour,
      this.flex = 1,
      required BuildContext context});

  // Constructor for icon button data
  Button.withIcon(
      {required this.onPressed,
      required this.colour,
      required this.icon,
      this.flex = 1,
      required BuildContext context});

  // Spacer, needed due to limitations on Expanded widgets
  Button.spacer({this.spacer = true}) {
    // assigning values to avoid worst case crash scenarios because these two
    // are designated "late"
    onPressed = () {};
    colour = Colors.white;
  }
}
