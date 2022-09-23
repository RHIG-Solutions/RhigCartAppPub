import 'input_properties.dart';

class RecoveryVerification {
  //TODO Verify data types and correct as needed
  InputProperties email = InputProperties();
  String cell = '';

  RecoveryVerification();

  //Checks if the Email address is present and valid, and sets appropriate error message
  bool isValid() {
    bool isValid = true;
    if (email.isEmpty()) {
      isValid = false;
    } else {
      //TODO implement email verification and replace dummy
      if (email.getValue() == 'v@lid') {
        cell = '0123456789';
      } else {
        email.error = 'Email address invalid';
        isValid = false;
      }
    }
    return isValid;
  }

  Map<String, dynamic> toJson() => {'email': email.getValue()};

  RecoveryVerification.fromJson(Map<String, dynamic> json)
      : cell = json['cell'];
}
