import 'input_properties.dart';

class OTP {
  InputProperties number1 = InputProperties();
  InputProperties number2 = InputProperties();
  InputProperties number3 = InputProperties();
  InputProperties number4 = InputProperties();
  String oTP = '';

  OTP();

  String combine() {
    String _oTP = number1.getValue() +
        number2.getValue() +
        number3.getValue() +
        number4.getValue();
    return _oTP;
  }

  Map<String, dynamic> toJson() => {'OTP': oTP};
}
