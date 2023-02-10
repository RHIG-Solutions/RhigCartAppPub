import 'package:rhig_cart_vendor/models/dummy_server_model.dart';
import 'input_properties.dart';

class Login {
  InputProperties email = InputProperties();
  InputProperties password = InputProperties();

  late String loggedInAccount;

  bool successful() {
    bool success = false;
    //TODO: Add login check with server here, replacing dummy
    if (myServer.doLogin(
        email: email.getValue(), password: password.getValue())) {
      loggedInAccount = email.getValue();
      success = true;
    }
    return success;
  }
}
