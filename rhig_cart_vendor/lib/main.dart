// Imports
// Misc
import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';

// Screens
import 'package:rhig_cart_vendor/screens/dashboard_screen.dart';
import 'package:rhig_cart_vendor/screens/login_screen.dart';
import 'package:rhig_cart_vendor/screens/password_reset_success_screen.dart';
import 'package:rhig_cart_vendor/screens/recover_1_screen.dart';
import 'package:rhig_cart_vendor/screens/recover_2_screen.dart';
import 'package:rhig_cart_vendor/screens/recover_3_screen.dart';
import 'package:rhig_cart_vendor/screens/test_screen.dart';
import 'package:rhig_cart_vendor/screens/signup_1_screen.dart';
import 'package:rhig_cart_vendor/screens/signup_2_screen.dart';
import 'package:rhig_cart_vendor/screens/signup_3_screen.dart';
import 'package:rhig_cart_vendor/screens/signup_4_screen.dart';
import 'package:rhig_cart_vendor/screens/welcome_screen.dart';
import 'package:rhig_cart_vendor/screens/theme_selector_screen.dart';
import 'package:rhig_cart_vendor/screens/my_clients_screen.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';
import 'package:rhig_cart_vendor/screens/edit_client_screen.dart';

// Models
import 'package:rhig_cart_vendor/models/recovery_model.dart';
import 'package:rhig_cart_vendor/models/edit_vendor_model.dart';
import 'package:rhig_cart_vendor/models/dummy_server_model.dart';

void main() => runApp(const RhigCartVendor());

class RhigCartVendor extends StatefulWidget {
  const RhigCartVendor({Key? key}) : super(key: key);

  @override
  State<RhigCartVendor> createState() => _RhigCartVendorState();
}

class _RhigCartVendorState extends State<RhigCartVendor> {
  @override
  Widget build(BuildContext context) {
    //TODO Remove dummy server start when testing complete
    myServer.serverStart();
    return MaterialApp(
      home: ValueListenableBuilder(
        valueListenable: myPrefs.loadNotifier,
        builder: (context, value, _) {
          // Checks if data loading is complete, displays pertinent screen
          if (myPrefs.loadComplete == false) {
            return loadingScreen();
          } else {
            return MaterialApp(
              theme: ThemeData(
                fontFamily: 'AvinerNext',
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Color(myPrefs.dColourMain1),
                ),
              ),
              routes: {
                '/': (context) => const LoginScreen(),
                '/recover1': (context) => const Recover1(),
                '/passwordresetsuccess': (context) =>
                    const PasswordResetSuccess(),
                '/themeselector': (context) => const ThemeSelector(),
                '/dashboard': (context) => const Dashboard(),
                '/clients': (context) => const MyClients(),
                '/test': (context) =>
                    const Test(), //TODO: Remove test route when done
              },
              onGenerateRoute: (settings) {
                if (settings.name == '/signup1') {
                  final value =
                      settings.arguments as EditVendor; // Retrieve the value.
                  return MaterialPageRoute(builder: (_) => SignUp1(value));
                }
                if (settings.name == '/signup2') {
                  final value =
                      settings.arguments as EditVendor; // Retrieve the value.
                  return MaterialPageRoute(builder: (_) => SignUp2(value));
                }
                if (settings.name == '/signup3') {
                  final value =
                      settings.arguments as EditVendor; // Retrieve the value.
                  return MaterialPageRoute(builder: (_) => SignUp3(value));
                }
                if (settings.name == '/signup4') {
                  final value =
                      settings.arguments as EditVendor; // Retrieve the value.
                  return MaterialPageRoute(builder: (_) => SignUp4(value));
                }
                if (settings.name == '/welcome') {
                  final value =
                      settings.arguments as String; // Retrieve the value.
                  return MaterialPageRoute(builder: (_) => Welcome(value));
                }
                if (settings.name == '/recover2') {
                  final value = settings.arguments
                      as RecoveryVerification; // Retrieve the value.
                  return MaterialPageRoute(builder: (_) => Recover2(value));
                }
                if (settings.name == '/recover3') {
                  final value = settings.arguments
                      as RecoveryVerification; // Retrieve the value.
                  return MaterialPageRoute(builder: (_) => Recover3(value));
                }
                if (settings.name == '/editclient') {
                  final value =
                      settings.arguments as String; // Retrieve the value.
                  return MaterialPageRoute(
                      builder: (_) => EditClientScreen(value));
                }

                return null;
              },
              initialRoute: '/',
            );
          }
        },
      ),
    );
  }
}
