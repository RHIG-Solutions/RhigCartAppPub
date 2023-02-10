import 'package:rhig_cart_vendor/models/dummy_server_model.dart';

import 'input_properties.dart';

class OTP {
  InputProperties number1 = InputProperties();
  InputProperties number2 = InputProperties();
  InputProperties number3 = InputProperties();
  InputProperties number4 = InputProperties();
  String oTP = '';

  String combine() {
    String _oTP = number1.getValue() +
        number2.getValue() +
        number3.getValue() +
        number4.getValue();
    return _oTP;
  }

  //TODO Replace dummy check with real
  bool verifyOTP({required String email}) {
    oTP = combine();
    if (myServer.checkOTP(email: email, oTP: oTP)) {
      return true;
    } else {
      return false;
    }
  }

  //Map<String, dynamic> toJson() => {'OTP': oTP};
}
