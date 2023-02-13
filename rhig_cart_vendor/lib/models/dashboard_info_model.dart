import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/models/session_variables.dart';
import 'package:rhig_cart_vendor/models/dummy_server_model.dart';

class DashboardInfo {
  late int _numberOfActiveClients;

  DashboardInfo() {
    // Gets needed information from server
    _numberOfActiveClients =
        myServer.getNumberOfActiveClients(loggedInUser: mySession.getUser());
  }

  // returns number of clients
  int getNumberOfActiveClients() {
    return _numberOfActiveClients;
  }
}

// Class to define dashboard button properties
class DashboardButton {
  // Which icon to display (not required, default value is menu icon)
  Icon icon;
  // List of Text widgets to display (required value)
  List<Text> descriptions;
  // Counter value for button
  int counter;
  // Target that the button is pointed at (required value)
  String target;

  DashboardButton(
      {this.icon = const Icon(Icons.menu),
      required this.descriptions,
      required this.target,
      this.counter = -1});
}
