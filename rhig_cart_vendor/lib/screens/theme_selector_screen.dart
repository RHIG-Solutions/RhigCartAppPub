import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({Key? key}) : super(key: key);

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: myPrefs.loadNotifier,
      builder: (context, value, _) {
        if (myPrefs.loadComplete == false) {
          return loadingScreen();
        } else {
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        myPrefs.save1();
                      });
                    },
                    child: const Text('Set Theme to Green'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        myPrefs.save2();
                      });
                    },
                    child: const Text('Set Theme to Blue'),
                  ),
                  TextButton(
                    onPressed: () {
                      myPrefs.loadPreferences();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text('Return to Login page'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
