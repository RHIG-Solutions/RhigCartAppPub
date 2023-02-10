import 'package:rhig_cart_vendor/models/dummy_server_model.dart';
import 'input_properties.dart';

class RecoveryVerification {
  InputProperties email = InputProperties();
  String cell = '';

  RecoveryVerification();

  //Checks if the Email address is present and valid, and sets appropriate error message
  bool isValid() {
    //TODO implement server side email verification and replace dummy
    // Queries server, if email is present, sends cell as response
    cell = myServer.checkVendorEmail(email: email.getValue());
    if (cell.isNotEmpty) {
      return true;
    } else {
      email.error = 'Email address invalid';
      return false;
    }
  }

  // Map<String, dynamic> toJson() => {'email': email.getValue()};
  //
  // RecoveryVerification.fromJson(Map<String, dynamic> json)
  //     : cell = json['cell'];
}
