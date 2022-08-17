import 'package:flutter/material.dart';

class InputProperties {
  FocusNode node = FocusNode();
  TextEditingController controller = TextEditingController();
  String error = '';

  //Used to check if field is empty during validation
  bool isEmpty() {
    if (controller.text.isEmpty) {
      error = 'Required Field';
      return true;
    } else {
      error = '';
      return false;
    }
  }

  //Returns raw value of Property
  String getValue() {
    return controller.text;
  }
}
