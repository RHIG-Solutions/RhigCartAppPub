import 'input_properties.dart';

class Vendor {
  InputProperties firstName = InputProperties();
  InputProperties lastName = InputProperties();
  InputProperties cell = InputProperties();
  InputProperties eMail = InputProperties();
  InputProperties street = InputProperties();
  InputProperties suburb = InputProperties();
  InputProperties city = InputProperties();
  InputProperties postalCode = InputProperties();
  InputProperties password = InputProperties();
  InputProperties passwordCheck = InputProperties();
  bool newsletter = true;

  //Checks if the flagged fields are empty, and sets error message if so.
  bool isValid(
      { //List of flagged fields, gets value of true if flagged for verification
      firstName = false,
      lastName = false,
      cell = false,
      eMail = false,
      street = false,
      suburb = false,
      city = false,
      postalCode = false,
      password = false}) {
    bool isValid = true;
    if (firstName == true && this.firstName.isEmpty()) {
      isValid = false;
    }
    if (lastName == true && this.lastName.isEmpty()) {
      isValid = false;
    }
    if (cell == true && this.cell.isEmpty()) {
      isValid = false;
    }
    if (eMail == true && this.eMail.isEmpty()) {
      isValid = false;
    }
    if (street == true && this.street.isEmpty()) {
      isValid = false;
    }
    if (suburb == true && this.suburb.isEmpty()) {
      isValid = false;
    }
    if (city == true && this.city.isEmpty()) {
      isValid = false;
    }
    if (postalCode == true && this.postalCode.isEmpty()) {
      isValid = false;
    }
    //validation for passwords. Checks if the fields match.
    if (password == true) {
      if (this.password.isEmpty() || passwordCheck.isEmpty()) {
        isValid = false;
      } else {
        if (this.password.controller.text != passwordCheck.controller.text) {
          passwordCheck.error = 'Passwords don\'t match';
          isValid = false;
        }
      }
    }
    return isValid;
  }

  //TODO Remove if initial avatar is to be icon and not initials
  //Returns vendor initials as a String
  String getInitials() {
    String _initials;
    _initials = firstName.controller.text[0] + lastName.controller.text[0];
    return _initials;
  }

  //TODO Verify json field names
  Map<String, dynamic> toJson() => {
        'firstname': firstName.getValue(),
        'lastname': lastName.getValue(),
        'cell': cell.getValue().replaceAll(' ', ''),
        'email': eMail.getValue(),
        'street': street.getValue(),
        'suburb': suburb.getValue(),
        'city': city.getValue(),
        'postalcode': postalCode.getValue(),
        'password': password.getValue(),
        'newsletter': newsletter,
      };
}
