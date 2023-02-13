import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/models/dummy_server_model.dart';
import 'package:rhig_cart_vendor/models/input_properties.dart';
import 'edit_address_model.dart';
import 'package:rhig_cart_vendor/models/client_model.dart';

class EditClient {
  InputProperties firstName = InputProperties();
  InputProperties lastName = InputProperties();
  InputProperties cell = InputProperties();
  InputProperties email = InputProperties();
  EditAddress address = EditAddress();
  ValueNotifier loadNotifier = ValueNotifier<bool>(true);

  // Checks if the fields are valid, and sets error message if not.
  // All fields are required, except suburb
  bool isValid() {
    bool isValid = true;
    if (firstName.isEmpty()) {
      isValid = false;
    }
    if (lastName.isEmpty()) {
      isValid = false;
    }
    if (cell.isEmpty()) {
      isValid = false;
    }
    if (email.isEmpty()) {
      isValid = false;
    }
    if (address.street.isEmpty()) {
      isValid = false;
    }
    if (address.city.isEmpty()) {
      isValid = false;
    }
    if (address.postalCode.isEmpty()) {
      isValid = false;
    }
    return isValid;
  }

  // Clears edit data
  clearInputs() {
    firstName.setValue(value: '');
    lastName.setValue(value: '');
    cell.setValue(value: '');
    email.setValue(value: '');
    address.street.setValue(value: '');
    address.suburb.setValue(value: '');
    address.city.setValue(value: '');
    address.postalCode.setValue(value: '');
  }

  // Saves client data to server
  saveClient(
      {required bool isNew,
      required String accountNumber,
      required String loggedInUser}) {
    if (isNew) {
      myServer.addClient(
          newClient: assignValues(),
          newAccountNumber:
              'ACC${(myServer.getNumberOfClients(loggedInUser: loggedInUser) + 1).toString().padLeft(6, '0')}');
    } else {
      myServer.updateClientData(
          accountNumber: accountNumber,
          client: assignValues(),
          loggedInUser: loggedInUser);
    }
  }

  // Assigns the values assigned during editing to the basic client model and
  // returns that
  Client assignValues() {
    Client myClient = Client();
    myClient.firstName = firstName.getValue();
    myClient.lastName = lastName.getValue();
    myClient.cell = cell.getValue();
    myClient.email = email.getValue();
    myClient.address = address.assignValues();
    return myClient;
  }

  // Checks if the new client already exists, returns specifics of client
  ExistingClientSpecifics alreadyExists({required String loggedInUser}) {
    ExistingClientSpecifics existingClientSpecifics = ExistingClientSpecifics();
    int index = myServer.alreadyExists(
        loggedInUser: loggedInUser,
        firstName: firstName.getValue(),
        lastName: lastName.getValue());
    if (index >= 0) {
      existingClientSpecifics.index = index;
      existingClientSpecifics.isActive = myServer.checkIfClientActive(
          index: index, loggedInUser: loggedInUser);
      existingClientSpecifics.accountNumber =
          myServer.getAccountNumber(loggedInUser: loggedInUser, index: index);
    }
    return existingClientSpecifics;
  }

  // Retrieves client data from server
  loadClient({required String loggedInUser, required String accountNumber}) {
    loadNotifier.value = false;
    Client myClient = myServer.loadClient(accountNumber: accountNumber);
    firstName.setValue(value: myClient.firstName);
    lastName.setValue(value: myClient.lastName);
    cell.setValue(value: myClient.cell);
    email.setValue(value: myClient.email);
    address.city.setValue(value: myClient.address.city);
    address.suburb.setValue(value: myClient.address.suburb);
    address.street.setValue(value: myClient.address.street);
    address.postalCode.setValue(value: myClient.address.postalCode);
    loadNotifier.value = true;
  }

  //Sets the client as inactive on the server
  deleteClient({required String loggedInUser, required String accountNumber}) {
    myServer.setClientInactive(
        accountNumber: accountNumber, loggedInUser: loggedInUser);
  }

  reactivateClient(
      {required String loggedInUser, required String accountNumber}) {
    myServer.setClientActive(
        accountNumber: accountNumber, loggedInUser: loggedInUser);
  }
}

// Set of data to pass to editing screen to check if client exists
class ExistingClientSpecifics {
  int index = -1;
  String accountNumber = '';
  bool isActive = false;
}
