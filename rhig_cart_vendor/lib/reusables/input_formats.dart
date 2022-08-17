import 'package:flutter/services.dart';

//Input field formatter for cell numbers
class CellFormatter extends TextInputFormatter {
  CellFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '');

    //Stop new input if number longer than 10 digits.
    if (newValue.text.length >= 13) {
      newText = oldValue.text;
    } else {
      //Adds spaces after 3 and 6 digits
      if (newText.length > 3) {
        newText = newText.substring(0, 3) + ' ' + newText.substring(3);
        if (newText.length > 7) {
          newText = newText.substring(0, 7) + ' ' + newText.substring(7);
        }
      }
    }

    TextSelection newSelection =
        TextSelection.fromPosition(TextPosition(offset: newText.length));

    return TextEditingValue(
      text: newText,
      selection: newSelection,
    );
  }
}
