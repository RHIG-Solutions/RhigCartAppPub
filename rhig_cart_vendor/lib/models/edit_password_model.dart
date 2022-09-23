import 'input_properties.dart';

class EditPassword {
  InputProperties password = InputProperties();
  InputProperties passwordCheck = InputProperties();

  //Password validation check, checks if both fields are populated, and match.
  bool isValid() {
    bool isValid = true;
    if (password.isEmpty() || passwordCheck.isEmpty()) {
      isValid = false;
    } else {
      if (password.controller.text != passwordCheck.controller.text) {
        passwordCheck.error = 'Passwords don\'t match';
        isValid = false;
      }
    }
    return isValid;
  }

  //Returns the password value.
  String getValue() {
    return password.controller.text;
  }
}
