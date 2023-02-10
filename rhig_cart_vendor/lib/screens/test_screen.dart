import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/theme_controller.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: myPrefs.loadNotifier,
      builder: (context, value, _) {
        if (myPrefs.loadComplete == false) {
          return loadingScreen();
        } else {
          return Scaffold(
            backgroundColor: Color(myPrefs.dColourBackground),
            appBar: AppBar(
              title: const Text('Test Page'),
            ),
            body: buildBottomButton(
              label: 'Testing Target',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/welcome',
                    arguments: 'test');
              },
            ),
          );
        }
      },
    );
  }
}
