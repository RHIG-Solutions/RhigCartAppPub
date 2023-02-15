// Page notes:
// Use the storeButton list on top to manage the buttons on the store page

import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/constants.dart';
import 'package:rhig_cart_vendor/models/dashboard_info_model.dart';
import 'package:rhig_cart_vendor/models/session_variables.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Target height for dashboard buttons
  final double kDashboardItemHeight = 150.0;
  // Lowest width a dashboard button may have
  final double kDashboardItemMinWidth = 130.0;
  // Number of items that cn be displayed per row
  int itemsPerRow = 0;
  // Variable used to help in determining button height
  double heightRatio = 1;
  // Dataset for dashboard variables
  DashboardInfo myDashboardInfo = DashboardInfo();
  // List for dashboard buttons
  List<DashboardButton> dashboardButtons = [];

  @override
  Widget build(BuildContext context) {
    // Add dashboard buttons to the list in the below method
    createButtonList();
    // Determines screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    // Determines maximum number of items that can be displayed per row
    final int maxItemsPerRow = ((screenWidth - (kSpacerStore * 2)) /
            (kDashboardItemMinWidth + kSpacerStore))
        .floor();
    // Sets actual number of items per row depending on available space and
    // items
    if (maxItemsPerRow > dashboardButtons.length) {
      itemsPerRow = dashboardButtons.length;
    } else {
      itemsPerRow = maxItemsPerRow;
    }
    // Determines the ratio of height to width for grid items
    heightRatio =
        ((screenWidth - ((itemsPerRow + 1) * kSpacerStore)) / itemsPerRow) /
            kDashboardItemHeight;

    return ValueListenableBuilder(
      valueListenable: myPrefs.loadNotifier,
      builder: (context, value, _) {
        // Checks if data loading is complete, displays pertinent screen
        if (myPrefs.loadComplete == false) {
          return loadingScreen();
        } else {
          return Scaffold(
            appBar: buildAppBar(context),
            body: buildBody(),
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
      //TODO Implement menu button functionality
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      title: const Center(
        child: Text('MY STORE'),
      ),
      actions: [
        //Exits store and returns to login
        IconButton(
          icon: const Icon(Icons.exit_to_app_rounded),
          onPressed: () {
            mySession.logOutUser();
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    );
  }

  RefreshIndicator buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        return refreshData();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kSpacerStore),
        child: CustomScrollView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              // Displays "Pull down to refresh" on top
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                centerTitle: true,
                pinned: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.refresh,
                      color: kColourRHIGLightGrey,
                    ),
                    Text(
                      'Pull down to refresh',
                      style:
                          TextStyle(color: kColourRHIGLightGrey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              // Displays the button grid
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Goes to storeButton target page
                        Navigator.pushNamed(
                                context, dashboardButtons[index].target)
                            .then((value) => setState(() {
                                  myDashboardInfo.needsReload = true;
                                }));
                      },
                      // Creates the store buttons
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Color(myPrefs.dColourMain1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dashboardButtons[index].icon,
                            for (int textCounter = 0;
                                textCounter <
                                    dashboardButtons[index].descriptions.length;
                                textCounter++)
                              dashboardButtons[index].descriptions[textCounter],
                            Expanded(
                              child: Container(),
                            ),
                            if (dashboardButtons[index].counter >= 0)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  dashboardButtons[index].counter.toString(),
                                  style: const TextStyle(
                                      fontSize: 30.0, color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: dashboardButtons.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: itemsPerRow,
                  crossAxisSpacing: kSpacerStore,
                  mainAxisSpacing: kSpacerStore,
                  childAspectRatio: (heightRatio),
                ),
              )
            ]),
      ),
    );
  }

  // Add/Rearrange buttons for dashboard in this method
  createButtonList() {
    myDashboardInfo.refreshDataFromServer();
    dashboardButtons.clear();
    if (dashboardButtons.isEmpty) {
      dashboardButtons.add(
        //My Clients button
        DashboardButton(
          icon: const Icon(
            Icons.group,
            color: Colors.white,
          ),
          descriptions: [
            const Text(
              'MY CLIENTS',
              style: TextStyle(color: Colors.white),
            ),
          ],
          counter: myDashboardInfo.getNumberOfActiveClients(),
          target: '/clients',
        ),
      );
      dashboardButtons.add(
        // My Suppliers button
        //TODO Implement Suppliers button functionality and counter
        DashboardButton(
          icon: const Icon(
            Icons.group,
            color: Colors.white,
          ),
          descriptions: [
            const Text(
              'MY SUPPLIERS',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              '(Coming Soon)',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 10,
              ),
            ),
          ],
          counter: 0,
          target: '/',
        ),
      );
      //TODO Remove dummy buttons when testing is complete
      dashboardButtons.add(
        DashboardButton(
          icon: const Icon(
            Icons.group,
            color: Colors.white,
          ),
          descriptions: [
            const Text(
              'Dummy 1',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              '(Ignore me)',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 10,
              ),
            ),
          ],
          target: '/',
        ),
      );
      dashboardButtons.add(
        DashboardButton(
          icon: const Icon(
            Icons.group,
            color: Colors.white,
          ),
          descriptions: [
            const Text(
              'Dummy 2',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              '(Ignore me)',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 10,
              ),
            ),
          ],
          target: '/',
        ),
      );
      dashboardButtons.add(
        DashboardButton(
          icon: const Icon(
            Icons.group,
            color: Colors.white,
          ),
          descriptions: [
            const Text(
              'Dummy 3',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              '(Ignore me)',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 10,
              ),
            ),
          ],
          target: '/',
        ),
      );
      dashboardButtons.add(
        DashboardButton(
          icon: const Icon(
            Icons.group,
            color: Colors.white,
          ),
          descriptions: [
            const Text(
              'Dummy 4',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              '(Ignore me)',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 10,
              ),
            ),
          ],
          target: '/',
        ),
      );
      dashboardButtons.add(
        DashboardButton(
          icon: const Icon(
            Icons.group,
            color: Colors.white,
          ),
          descriptions: [
            const Text(
              'Dummy 5',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              '(Ignore me)',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 10,
              ),
            ),
          ],
          target: '/',
        ),
      );
    }
  }

  // Refreshes the Dashboard page
  Future refreshData() async {
    //TODO Remove refresh delay when testing complete
    setState(() {
      // Recreates the button list, getting fresh data from the server
      createButtonList();
    });
    await Future.delayed(Duration(seconds: 3));
  }
}
