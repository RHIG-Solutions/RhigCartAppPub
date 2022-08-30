import 'input_properties.dart';

class Login {
  bool failed = false;

  InputProperties email = InputProperties();
  InputProperties password = InputProperties();

  late String loggedInAccount;

  bool successful() {
    bool _success = false;
    //TODO: Add login check with server here, replacing dummy
    if (email.getValue() == 'C' && password.getValue() == 'C') {
      loggedInAccount = email.getValue();
      failed = false;
      _success = true;
    } else {
      failed = true;
      _success = false;
    }
    return _success;
  }
}
