import 'input_properties.dart';
import 'package:rhig_cart_vendor/models/dummy_server_model.dart';

class EditPassword {
  //TODO Replace dummy server calls

  InputProperties password = InputProperties();
  InputProperties passwordCheck = InputProperties();
  Names vendorNames = Names();

  // Gets Vendor names from server
  Names getNames({required String email}) {
    vendorNames = myServer.getVendorNames(email: email);
    return vendorNames;
  }

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

  // Update password on server
  updatePassword({required String email}) {
    myServer.updateVendorPassword(email: email, password: password.getValue());
  }

  // Returns the password value.
  String getValue() {
    return password.controller.text;
  }

  // Returns initials of Vendor names
  String getInitials() {
    String initials;
    initials = vendorNames.firstName[0] + vendorNames.lastName[0];
    return initials;
  }
}

class Names {
  String firstName = '';
  String lastName = '';
}
