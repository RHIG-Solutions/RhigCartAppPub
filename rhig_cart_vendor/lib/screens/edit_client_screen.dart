// PAGE NOTES:
// Crash on my phone when trying to display popup in horizontal mode, i think
// my screen is too small

import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/constants.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';
import 'package:rhig_cart_vendor/models/edit_client_model.dart';
import 'package:rhig_cart_vendor/models/session_variables.dart';
import 'package:rhig_cart_vendor/reusables/loading_indicator.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/alerts.dart';

class EditClientScreen extends StatefulWidget {
  final String accountToEdit;
  const EditClientScreen(this.accountToEdit, {Key? key}) : super(key: key);

  @override
  State<EditClientScreen> createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  // Local version of accountToEdit
  String accountToEdit = '';
  // Creates object used for editing/creating a client
  EditClient myClient = EditClient();
  // Margins and spacing between editing input fields
  double inputMargin = 10.0;
  // Title for the page, set once at page creation
  late final String title;
  // Variable set to true if it is a new client
  late bool newClient;

  @override

  // Loads client data at page creation if it is an edit and not a new client
  void initState() {
    super.initState();
    // Sets account to edit as per arguments passed to page
    accountToEdit = widget.accountToEdit;
    if (accountToEdit != '') {
      newClient = false;
      myClient.loadClient(
          loggedInUser: SessionVariables().getUser(),
          accountNumber: accountToEdit);
      title =
          '${myClient.firstName.getValue()} ${myClient.lastName.getValue()}';
    } else {
      title = 'NEW CLIENT';
      newClient = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: myPrefs.loadNotifier,
      builder: (context, value, _) {
        // Checks if data loading is complete, displays pertinent screen
        if (myPrefs.loadComplete == false) {
          return loadingScreen();
        } else {
          return ValueListenableBuilder(
            valueListenable: myClient.loadNotifier,
            builder: (context, value, _) {
              if (myClient.loadNotifier.value == false) {
                return loadingIndicator(label: 'Loading Data...');
              } else {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Scaffold(
                    appBar: buildAppBar(context),
                    body: buildBody(),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kColourRHIGGrey,
      elevation: 0,
      // Button to return to My Store page
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_sharp),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/clients');
        },
      ),
      // Displays title with client name or "New Client", depending...
      title: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Text(title.isEmpty ? 'NEW CLIENT' : title),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Creates Contact details header
                Padding(
                  padding: EdgeInsets.only(
                      left: kSpacerStore,
                      right: kSpacerStore,
                      top: kSpacerStore,
                      bottom: 5),
                  child: Text(
                    'CONTACT DETAILS',
                    style: myPrefs.dHeader2ContrastStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kSpacerStore),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      children: [
                        // Creates First name editing field
                        Padding(
                          padding: EdgeInsets.only(
                              top: inputMargin,
                              left: inputMargin,
                              right: inputMargin),
                          child: InputField(
                            node: myClient.firstName.node,
                            nextNode: myClient.lastName.node,
                            controller: myClient.firstName.controller,
                            label: 'First Name',
                            hint: 'First Name',
                            hasIcon: true,
                            icon: Icons.perm_identity,
                            errorText: myClient.firstName.error,
                          ),
                        ),
                        // Creates last name editing field
                        Padding(
                          padding: EdgeInsets.only(
                              top: inputMargin,
                              left: inputMargin,
                              right: inputMargin),
                          child: InputField(
                            node: myClient.lastName.node,
                            nextNode: myClient.cell.node,
                            controller: myClient.lastName.controller,
                            label: 'Last Name',
                            hint: 'Last Name',
                            hasIcon: true,
                            icon: Icons.perm_identity,
                            errorText: myClient.lastName.error,
                          ),
                        ),
                        // Creates cell editing field
                        Padding(
                          padding: EdgeInsets.only(
                              top: inputMargin,
                              left: inputMargin,
                              right: inputMargin),
                          child: InputField(
                            node: myClient.cell.node,
                            nextNode: myClient.email.node,
                            controller: myClient.cell.controller,
                            isCellNumber: true,
                            isNumber: true,
                            label: 'Cell Number',
                            hint: '000 000 0000',
                            hasIcon: true,
                            icon: Icons.phone,
                            errorText: myClient.cell.error,
                          ),
                        ),
                        // Creates Email editing field
                        Padding(
                          padding: EdgeInsets.only(
                              top: inputMargin,
                              left: inputMargin,
                              right: inputMargin,
                              bottom: inputMargin),
                          child: InputField(
                            node: myClient.email.node,
                            nextNode: myClient.address.street.node,
                            controller: myClient.email.controller,
                            label: 'Email Address',
                            hint: 'Email Address',
                            hasIcon: true,
                            icon: Icons.mail,
                            errorText: myClient.email.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Creates Address header
                Padding(
                  padding: EdgeInsets.only(
                      left: kSpacerStore,
                      right: kSpacerStore,
                      top: kSpacerStore,
                      bottom: 5),
                  child: Text(
                    'ADDRESS DETAILS',
                    style: myPrefs.dHeader2ContrastStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: kSpacerStore,
                      right: kSpacerStore,
                      bottom: kSpacerStore),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      children: [
                        // Creates street editing field
                        Padding(
                          padding: EdgeInsets.only(
                              top: inputMargin,
                              left: inputMargin,
                              right: inputMargin),
                          child: InputField(
                            node: myClient.address.street.node,
                            nextNode: myClient.address.suburb.node,
                            controller: myClient.address.street.controller,
                            label: 'Street',
                            hint: 'Street',
                            hasIcon: true,
                            icon: Icons.pin_drop,
                            errorText: myClient.address.street.error,
                          ),
                        ),
                        // Creates suburb editing field
                        Padding(
                          padding: EdgeInsets.only(
                              top: inputMargin,
                              left: inputMargin,
                              right: inputMargin),
                          child: InputField(
                            node: myClient.address.suburb.node,
                            nextNode: myClient.address.city.node,
                            controller: myClient.address.suburb.controller,
                            label: 'Suburb',
                            hint: 'Suburb',
                            hasIcon: true,
                            icon: Icons.pin_drop,
                            isRequired: false,
                            errorText: myClient.address.suburb.error,
                          ),
                        ),
                        // Creates city editing field
                        Padding(
                          padding: EdgeInsets.only(
                              top: inputMargin,
                              left: inputMargin,
                              right: inputMargin),
                          child: InputField(
                            node: myClient.address.city.node,
                            nextNode: myClient.address.postalCode.node,
                            controller: myClient.address.city.controller,
                            label: 'City',
                            hint: 'City',
                            hasIcon: true,
                            icon: Icons.pin_drop,
                            errorText: myClient.address.city.error,
                          ),
                        ),
                        // Creates Postal code editing field
                        Padding(
                          padding: EdgeInsets.all(inputMargin),
                          child: InputField(
                            node: myClient.address.postalCode.node,
                            nextNode: myClient.address.postalCode.node,
                            controller: myClient.address.postalCode.controller,
                            label: 'Postal Code',
                            hint: 'Postal Code',
                            hasIcon: true,
                            icon: Icons.pin_drop,
                            isNumber: true,
                            isLast: true,
                            errorText: myClient.address.postalCode.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Color(myPrefs.dColourMain1),
        ),
        // Builds bottom button row
        Padding(
          padding: EdgeInsets.all(kSpacerStore),
          child: buildBottomButtonRow(
            buttons: [
              // Delete button
              Button.withIcon(
                context: context,
                onPressed: () => showDeleteDialog(
                  context,
                  messages: [
                    newClient
                        ? const Text('Are you sure you want to clear the form?')
                        : Text(
                            'Are you sure you want to remove ${myClient.firstName.getValue()} ${myClient.lastName.getValue()}?'),
                  ],
                  buttons: [
                    // Sends the list of buttons and their actions to the delete
                    // Dialog
                    // No button just returns to edit screen.
                    Button(
                        label: 'NO',
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        colour: kColourRHIGGrey,
                        context: context),
                    // Spacer, needed due to limitations on Expanded widgets
                    Button.spacer(),
                    // Yes button deletes client and returns to client list, or
                    // in the case of a new client clears the fields and returns
                    // to editor
                    Button(
                        label: 'YES',
                        onPressed: () {
                          newClient
                              ? myClient.clearInputs()
                              : myClient.deleteClient(
                                  loggedInUser: mySession.getUser(),
                                  accountNumber: accountToEdit);
                          Navigator.of(context, rootNavigator: true).pop();
                          if (newClient == false) {
                            Navigator.pushReplacementNamed(context, '/clients');
                          }
                        },
                        colour: Colors.red,
                        context: context),
                  ],
                ),
                colour: Colors.red,
                icon: const Icon(Icons.delete),
                flex: 1,
              ),
              // Spacer, needed due to limitations on Expanded widgets
              Button.spacer(),
              // Save client button
              Button(
                  label: 'SAVE CLIENT',
                  onPressed: () {
                    setState(() {
                      // Checks if all required fields are valid
                      if (myClient.isValid()) {
                        // Checks if the client already exists and acts accordingly
                        ExistingClientSpecifics existingClientSpecifics =
                            ExistingClientSpecifics();
                        if (newClient) {
                          existingClientSpecifics = myClient.alreadyExists(
                              loggedInUser: mySession.getUser());
                        }
                        if (existingClientSpecifics.index != -1 &&
                            newClient == true) {
                          showDeleteDialog(context, messages: [
                            existingClientSpecifics.isActive
                                ? const Text(
                                    'That client is already registered, would you like to open it for editing?')
                                : const Text(
                                    'That client is already listed, but inactive. Would you like to reactivate their account and edit it?')
                          ], buttons: [
                            // Button returns user to the editing screen
                            Button(
                                label: 'NO',
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                colour: kColourRHIGGrey,
                                context: context),
                            // Spacer, needed due to limitations on Expanded widgets
                            Button.spacer(),
                            // Yes button restores client if it was inactive,
                            // and opens it for editing
                            Button(
                                label: 'YES',
                                onPressed: () {
                                  setState(() {
                                    newClient = false;
                                    accountToEdit =
                                        existingClientSpecifics.accountNumber;
                                    existingClientSpecifics.isActive
                                        ? null
                                        : myClient.reactivateClient(
                                            loggedInUser: mySession.getUser(),
                                            accountNumber:
                                                existingClientSpecifics
                                                    .accountNumber);
                                    myClient.loadClient(
                                        loggedInUser: mySession.getUser(),
                                        accountNumber: existingClientSpecifics
                                            .accountNumber);
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  });
                                },
                                colour: Colors.green,
                                context: context),
                          ]);
                        } else {
                          myClient.saveClient(
                              loggedInUser: mySession.getUser(),
                              isNew: newClient,
                              accountNumber: accountToEdit);
                          showConfirmDialog(
                            context,
                            messages: [
                              newClient
                                  ? const Text(
                                      'Client has successfully been added.')
                                  : const Text(
                                      'Client has successfully been saved.'),
                            ],
                            buttons: [
                              // Confirmation button returns to client screen.
                              Button(
                                  label: 'CLOSE',
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    Navigator.pushReplacementNamed(
                                        context, '/clients');
                                  },
                                  colour: kColourRHIGGrey,
                                  context: context),
                            ],
                          );
                        }
                      }
                    });
                  },
                  colour: Color(myPrefs.dColourMain1),
                  flex: 3,
                  context: context)
            ],
          ),
        ),
      ],
    );
  }
}
