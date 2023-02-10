// Page notes:
// Use the storeButton list on top to manage the buttons on the store page

import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/constants.dart';
import 'package:rhig_cart_vendor/theme_controller.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';

class Dashboard extends StatefulWidget {
  final String loggedInUser;
  const Dashboard(this.loggedInUser, {Key? key}) : super(key: key);

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

  // List of store buttons. Add or remove needed buttons here

  // My Clients button
  List<StoreButton> storeButtons = [
    StoreButton(
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
      displayCounter: true,
      target: '/clients',
    ),
    // My Suppliers button
    StoreButton(
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
      displayCounter: true,
      target: '/',
    ),
    //TODO Remove dummy buttons when testing is complete
    StoreButton(
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
    StoreButton(
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
    StoreButton(
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
      displayCounter: true,
      target: '/',
    ),
    StoreButton(
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
      displayCounter: false,
      target: '/',
    ),
    StoreButton(
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
      displayCounter: true,
      target: '/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Determines screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    // Determines maximum number of items that can be displayed per row
    final int maxItemsPerRow = ((screenWidth - (kSpacerStore * 2)) /
            (kDashboardItemMinWidth + kSpacerStore))
        .floor();
    // Sets actual number of items per row depending on available space and
    // items
    if (maxItemsPerRow > storeButtons.length) {
      itemsPerRow = storeButtons.length;
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
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    );
  }

  RefreshIndicator buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        //TODO Implement actions of refresh on scroll down, removing artificial testing delay.
        return Future<void>.delayed(const Duration(seconds: 2));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kSpacerStore),
        child: CustomScrollView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              // Displays "Pull down to refresh" on top
              SliverAppBar(
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
                        Navigator.pushReplacementNamed(
                            context, storeButtons[index].target,
                            arguments: widget.loggedInUser);
                      },
                      // Creates the store buttons
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Color(myPrefs.dColourMain1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            storeButtons[index].icon,
                            for (int textCounter = 0;
                                textCounter <
                                    storeButtons[index].descriptions.length;
                                textCounter++)
                              storeButtons[index].descriptions[textCounter],
                            Expanded(
                              child: Container(),
                            ),
                            if (storeButtons[index].displayCounter)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  storeButtons[index].counter.toString(),
                                  style: const TextStyle(
                                      fontSize: 30.0, color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: storeButtons.length,
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
}

// Class to define store button properties
class StoreButton {
  // Which icon to display (not required, default value is menu icon)
  Icon icon;
  // List of Text widgets to display (required value)
  List<Text> descriptions;
  // Counter value for button
  int counter = 0;
  // Switch to determine if the above counter is to be displayed (default = false)
  bool displayCounter;
  // Target that the button is pointed at (required value)
  String target;

  StoreButton(
      {this.icon = const Icon(Icons.menu),
      required this.descriptions,
      this.displayCounter = false,
      required this.target});
}
