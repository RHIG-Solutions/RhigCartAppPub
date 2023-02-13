import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/models/dummy_server_model.dart';

// List of Basic Client info, including counters and controllers
class BasicClientList {
  // Basic client List
  List<ClientBasics> myClients = [];
  // boolean to indicate whether data retrieval from server is complete
  final loadNotifier = ValueNotifier<bool>(false);
  // boolean to indicate whether client search is complete
  ValueNotifier searchNotifier = ValueNotifier<bool>(true);
  // Counter for number of active clients
  int activeClients = 0;
  // Boolean, sets to true if no clients match your search.
  bool listEmpty = false;
  // Switch to signify if client list has been populated
  bool clientListPopulated = false;

  // Retrieves client data from the server, checking active status
  loadClientList({required String loggedInUser}) {
    //TODO Replace dummy server calls with real thing
    //TODO Implement error catching in data retrieval
    if (loadNotifier.value == false) {
      myClients.clear();
      activeClients = 0;

      for (int index = 0;
          index < myServer.getNumberOfClients(loggedInUser: loggedInUser);
          index++) {
        ClientBasics myClient =
            myServer.getClientBasics(index: index, loggedInUser: loggedInUser);

        if (myClient.isActive) {
          myClients.add(ClientBasics());
          myClients[activeClients] = myClient;
          activeClients++;
        }
      }
    }
    loadNotifier.value = true;
  }

  // Searches client list for a specific string
  searchClientList({required String criteria}) {
    listEmpty = true;
    // String that contains all the client information in one
    String infoConcat = '';
    for (int index = 0; index < myClients.length; index++) {
      myClients[index].mustDisplay = true;
      infoConcat =
          '${myClients[index].firstName} ${myClients[index].lastName} ${myClients[index].accountNumber}'
              .toLowerCase();
      if (infoConcat.contains(criteria.toLowerCase())) {
        listEmpty = false;
      } else {
        myClients[index].mustDisplay = false;
      }
    }
    searchNotifier.value = true;
  }
}

// Model for basic client information
class ClientBasics {
  String firstName = '';
  String lastName = '';
  String accountNumber = '';
  bool isActive = true;
  bool mustDisplay = true;
}
