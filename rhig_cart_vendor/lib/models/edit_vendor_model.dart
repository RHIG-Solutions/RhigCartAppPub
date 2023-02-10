import 'package:rhig_cart_vendor/models/dummy_server_model.dart';

import 'input_properties.dart';
import 'edit_password_model.dart';
import 'edit_address_model.dart';
import 'vendor_model.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

class EditVendor {
  final Vendor _myVendor = Vendor();
  InputProperties firstName = InputProperties();
  InputProperties lastName = InputProperties();
  InputProperties cell = InputProperties();
  InputProperties email = InputProperties();
  EditAddress address = EditAddress();
  EditPassword password = EditPassword();
  bool newsletter = true;
  String profileImage = '';

  //Checks if the flagged fields are valid, and sets error message if so.
  bool isValid(
      { //List of flagged fields, gets value of true if flagged for verification
      firstName = false,
      lastName = false,
      cell = false,
      email = false,
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
    if (email == true && this.email.isEmpty()) {
      isValid = false;
    }
    if (street == true && address.street.isEmpty()) {
      isValid = false;
    }
    if (suburb == true && address.suburb.isEmpty()) {
      isValid = false;
    }
    if (city == true && address.city.isEmpty()) {
      isValid = false;
    }
    if (postalCode == true && address.postalCode.isEmpty()) {
      isValid = false;
    }
    if (password == true) {
      isValid = this.password.isValid();
    }
    return isValid;
  }

  //Returns vendor initials as a String
  String getInitials() {
    String initials;
    initials = firstName.controller.text[0] + lastName.controller.text[0];
    return initials;
  }

  void encodeProfileImage(File image) async {
    Uint8List imagebytes = await image.readAsBytes(); //convert to bytes
    profileImage =
        base64.encode(imagebytes); //Return the image as base64 String
  }

  // Assigns the values assigned during editing to the basic vendor model and
  // returns that
  assignValues() {
    _myVendor.firstName = firstName.getValue();
    _myVendor.lastName = lastName.getValue();
    _myVendor.cell = cell.getValue().replaceAll(' ', '');
    _myVendor.email = email.getValue();
    _myVendor.address = address.assignValues();
    _myVendor.password = password.getValue();
    _myVendor.newsletter = newsletter;
    _myVendor.profileImage = profileImage;
  }

  // Creates new vendor on server
  addVendorToServer() {
    assignValues();
    myServer.addVendor(newVendor: _myVendor);
  }
}
