import 'input_properties.dart';

class Login {
  InputProperties email = InputProperties();
  InputProperties password = InputProperties();

  late String loggedInAccount;

  bool successful() {
    bool success = false;
    //TODO: Add login check with server here, replacing dummy
    if (email.getValue() == 'C' && password.getValue() == 'C') {
      loggedInAccount = email.getValue();
      success = true;
    } else {
      success = false;
    }
    return success;
  }
}
