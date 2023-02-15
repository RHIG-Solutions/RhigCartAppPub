// Page notes:

import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/constants.dart';
import 'package:rhig_cart_vendor/models/basic_client_list_model.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';
import 'package:rhig_cart_vendor/reusables/loading_indicator.dart';
import 'package:rhig_cart_vendor/models/session_variables.dart';

class MyClients extends StatefulWidget {
  const MyClients({Key? key}) : super(key: key);

  @override
  State<MyClients> createState() => _MyClientsState();
}

class _MyClientsState extends State<MyClients> {
  // Controller for search bar
  TextEditingController searchController = TextEditingController();
  // List with basic client information
  BasicClientList myClients = BasicClientList();

  @override
  Widget build(BuildContext context) {
    myClients.loadClientList(loggedInUser: mySession.getUser());
    return ValueListenableBuilder(
      valueListenable: myPrefs.loadNotifier,
      builder: (context, value, _) {
        // Checks if data loading is complete, displays pertinent screen
        if (myPrefs.loadComplete == false) {
          return loadingScreen();
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

  // Builds AppBar
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kColourRHIGGrey,
      elevation: 0,
      // Button to return to My Store page
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_sharp),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Center(
        child: Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Text('MY CLIENTS'),
        ),
      ),
    );
  }

  // Builds page body
  Widget buildBody() {
    return Column(
      children: [
        buildSearchBar(),
        Expanded(
          // Builder waiting for data to be retrieved from server
          child: ValueListenableBuilder(
            valueListenable: myClients.loadNotifier,
            builder: (context, value, _) {
              if (myClients.loadNotifier.value == false) {
                return loadingIndicator();
              } else {
                // Creates list of clients to be displayed
                List<ClientBasics> myClientList =
                    List.from(myClients.myClients);
                // Building waiting for any searches to complete
                return ValueListenableBuilder(
                  valueListenable: myClients.searchNotifier,
                  builder: (context, value, _) {
                    if (myClients.searchNotifier.value == false) {
                      return loadingIndicator();
                    } else {
                      // Displays message if no matches to search is found
                      if (myClients.listEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: kSpacerStore),
                          child: Text(
                            'NO MATCHING CLIENTS',
                            style: myPrefs.dHeader3Main1Style,
                          ),
                        );
                      } else {
                        // Displays list of relevant clients
                        return buildClientList(myClientList, context);
                      }
                    }
                  },
                );
              }
            },
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Color(myPrefs.dColourMain1),
        ),
        // Builds bottom button
        Padding(
          padding: EdgeInsets.all(kSpacerStore),
          child: buildBottomButton(
              label: '+ NEW CLIENT',
              onPressed: () {
                Navigator.of(context)
                    .pushNamed("/editclient", arguments: '')
                    .then((value) => setState(() {
                          myClients.loadNotifier.value = false;
                        }));
              }),
        ),
      ],
    );
  }

  // Builds Searchbar area
  Container buildSearchBar() {
    return Container(
      color: kColourRHIGGrey,
      child: Padding(
        padding: EdgeInsets.only(
            left: kSpacerStore, right: kSpacerStore, bottom: kSpacerStore),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kInputRadius),
          ),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                myClients.searchNotifier.value = false;
                myClients.searchClientList(criteria: searchController.text);
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.search,
                  color: Color(myPrefs.dColourMain1),
                ),
              ),
              // IconButton to clear search bar
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: kColourRHIGLightGrey,
                ),
                onPressed: () {
                  setState(
                    () {
                      searchController.text = '';
                      myClients.searchNotifier.value = false;
                      myClients.searchClientList(
                          criteria: searchController.text);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Builds list of relevant clients
  ListView buildClientList(
      List<ClientBasics> myClientList, BuildContext context) {
    return ListView(
      children: [
        for (int index = 0; index < myClients.activeClients; index++)
          if (myClientList[index].mustDisplay)
            // Sends user to client edit page with user and
            // account number as arguments
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed("/editclient",
                        arguments: myClientList[index].accountNumber)
                    .then((value) => setState(() {
                          myClients.loadNotifier.value = false;
                        }));
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: kSpacerStore, right: kSpacerStore, top: kSpacerStore),
                child: Material(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(kInputRadius),
                  ),
                  elevation: 5,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: kColourRHIGLightGrey),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(kInputRadius),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            color: Color(myPrefs.dColourContrast),
                            height: 80,
                            width: 30,
                            child: const Icon(
                              Icons.group,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${myClientList[index].firstName} ${myClientList[index].lastName}',
                                  style: myPrefs.dHeader3Main1Style,
                                ),
                                Text(
                                  myClientList[index].accountNumber,
                                  style: kLabelLightStyle,
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ),
            )
      ],
    );
  }
}
