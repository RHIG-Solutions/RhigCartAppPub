//TODO Remove Dummy server when no longer needed, read below.
// NOTES:
// Remove dummy when server comms gets implemented, then fix errors where real
// server calls must be added. Remember to add error catching where needed

import 'package:rhig_cart_vendor/models/client_model.dart';
import 'package:rhig_cart_vendor/models/basic_client_list_model.dart';
import 'package:rhig_cart_vendor/models/vendor_model.dart';
import 'package:rhig_cart_vendor/models/edit_password_model.dart';

DummyServer myServer = DummyServer();

class DummyServer {
  List<Vendor> _myVendors = [];
  List<Client> _myClients = [];
  bool started = false;

  DummyServer() {
    print('Initializing Dummy Server');

    //Setup Dummy vendor with basic info
    _myVendors.add(Vendor());
    _myVendors[0].email = 'C';
    _myVendors[0].password = 'C';
    _myVendors[0].cell = '0123456789';
    _myVendors[0].firstName = 'Test';
    _myVendors[0].lastName = 'Case';

    //Setup dummy client list
    for (int index = 0; index < 10; index++) {
      _myClients.add(Client());
      _myClients[index].accountNumber =
          'ACC${(index + 1).toString().padLeft(6, '0')}';
      _myClients[index].firstName = 'Name${index + 1}';
      _myClients[index].lastName = 'Surname${index + 1}';
      _myClients[index].email = 'v@lid';
      _myClients[index].cell = '0123456789';
      _myClients[index].address.city = 'Heresville';
      _myClients[index].address.suburb = 'Suburbia';
      _myClients[index].address.street = 'OurLane';
      _myClients[index].address.postalCode = '12345';
    }

    print('Initialization Complete');
  }

  void serverStart() {
    print('Starting Server');
    started = true;
  }

  // Do login details verification
  bool doLogin({required String email, required String password}) {
    final int index = _myVendors.indexWhere((vendor) => vendor.email == email);
    if (index == -1) {
      return false;
    } else {
      if (email == _myVendors[index].email &&
          password == _myVendors[index].password) {
        return true;
      } else {
        return false;
      }
    }
  }

  // Verifies vendor email address for password recovery, returns cell if valid
  String checkVendorEmail({required String email}) {
    final int index = _myVendors.indexWhere((vendor) => vendor.email == email);
    if (index == -1) {
      return '';
    } else {
      if (email == _myVendors[index].email) {
        return _myVendors[index].cell;
      } else {
        return '';
      }
    }
  }

  // Checks OTP (always 1234 on dummy server) so did not do any lookups as I do
  // not know how this is handles server side
  bool checkOTP({required String email, required String oTP}) {
    if (oTP == '1234') {
      return true;
    } else {
      return false;
    }
  }

  // Returns vendor names linked to email address
  Names getVendorNames({required String email}) {
    final int index = _myVendors.indexWhere((vendor) => vendor.email == email);
    Names vendorNames = Names();
    vendorNames.firstName = _myVendors[index].firstName;
    vendorNames.lastName = _myVendors[index].lastName;
    return vendorNames;
  }

  // Updates password on server
  updateVendorPassword({required String email, required String password}) {
    final int index = _myVendors.indexWhere((vendor) => vendor.email == email);
    _myVendors[index].password = password;
  }

  // Adds a new vendor to the database
  addVendor({required Vendor newVendor}) {
    _myVendors.add(Vendor());
    int index = _myVendors.length - 1;
    _myVendors[index] = newVendor;
  }

  // Returns number of clients in database
  int getNumberOfClients({required String loggedInUser}) {
    return _myClients.length;
  }

  // Returns number of active clients in database
  int getNumberOfActiveClients({required String loggedInUser}) {
    int numberOfActiveClients = 0;
    for (int index = 0; index < _myClients.length; index++) {
      _myClients[index].isActive ? numberOfActiveClients++ : null;
    }
    return numberOfActiveClients;
  }

  // Returns a client object as per account number
  Client loadClient({required accountNumber}) {
    final int index = _myClients
        .indexWhere((client) => client.accountNumber == accountNumber);
    return _myClients[index];
  }

  // Sets a client to inactive upon account deletion, data stays on server
  void setClientInactive(
      {required String accountNumber, required String loggedInUser}) {
    final int index = _myClients
        .indexWhere((client) => client.accountNumber == accountNumber);
    _myClients[index].isActive = false;
  }

  // Sets a client to active
  void setClientActive(
      {required String accountNumber, required String loggedInUser}) {
    final int index = _myClients
        .indexWhere((client) => client.accountNumber == accountNumber);
    _myClients[index].isActive = true;
  }

  // Returns current status(active/inactive) of client
  bool checkIfClientActive({required int index, required String loggedInUser}) {
    return _myClients[index].isActive;
  }

  // Returns basic client info from server as per account number
  ClientBasics getClientBasics(
      {required int index, required String loggedInUser}) {
    ClientBasics myClient = ClientBasics();
    myClient.firstName = _myClients[index].firstName;
    myClient.lastName = _myClients[index].lastName;
    myClient.accountNumber = _myClients[index].accountNumber;
    myClient.isActive = _myClients[index].isActive;
    return myClient;
  }

  // Returns client account number at specific index.
  String getAccountNumber({required String loggedInUser, required int index}) {
    return _myClients[index].accountNumber;
  }

  // Checks if the client already exists.
  int alreadyExists(
      {required String loggedInUser,
      required String firstName,
      required String lastName}) {
    int value = -1;
    for (int index = 0; index < _myClients.length; index++) {
      if (_myClients[index].firstName.toLowerCase() ==
              firstName.toLowerCase() &&
          _myClients[index].lastName.toLowerCase() == lastName.toLowerCase()) {
        return index;
      }
    }
    return value;
  }

  // Adds a new client to the client list
  addClient({required Client newClient, required String newAccountNumber}) {
    int newIndex = _myClients.length;
    _myClients.add(newClient);
    _myClients[newIndex].accountNumber = newAccountNumber;
  }

  //
  updateClientData(
      {required String accountNumber,
      required Client client,
      required String loggedInUser}) {
    final int index = _myClients
        .indexWhere((client) => client.accountNumber == accountNumber);
    _myClients[index] = client;
    _myClients[index].accountNumber = accountNumber;
  }
}
