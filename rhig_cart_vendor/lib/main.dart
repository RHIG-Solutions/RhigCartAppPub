import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/models/recovery_model.dart';
import 'package:rhig_cart_vendor/reusables/constants.dart';
import 'package:rhig_cart_vendor/screens/login.dart';
import 'package:rhig_cart_vendor/screens/password_reset_success.dart';
import 'package:rhig_cart_vendor/screens/recover_1.dart';
import 'package:rhig_cart_vendor/screens/recover_2.dart';
import 'package:rhig_cart_vendor/screens/recover_3.dart';
import 'package:rhig_cart_vendor/screens/test.dart';
import 'package:rhig_cart_vendor/screens/signup_1.dart';
import 'package:rhig_cart_vendor/screens/signup_2.dart';
import 'package:rhig_cart_vendor/screens/signup_3.dart';
import 'package:rhig_cart_vendor/screens/signup_4.dart';
import 'package:rhig_cart_vendor/screens/welcome.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/models/edit_vendor_model.dart';

void main() => runApp(const RhigCartVendor());

class RhigCartVendor extends StatefulWidget {
  const RhigCartVendor({Key? key}) : super(key: key);

  @override
  State<RhigCartVendor> createState() => _RhigCartVendorState();
}

class _RhigCartVendorState extends State<RhigCartVendor> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(accentColor: kRHIGDarkGreen),
        scaffoldBackgroundColor: kRHIGBackGround,
        fontFamily: 'AvinerNext',
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: kRHIGDarkGreen,
          selectionHandleColor: kRHIGDarkGreen,
          selectionColor: kSelection,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: kRHIGGrey),
        ),
        inputDecorationTheme: InputDecorationTheme(
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(kInputRadius))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(kInputRadius))),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(kInputRadius))),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kRHIGDarkGreen),
                borderRadius: BorderRadius.all(Radius.circular(kInputRadius)))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: kRHIGDarkGreen, onPrimary: kRHIGBackGround),
        ),
      ),
      routes: {
        '/': (context) => const LoginScreen(),
        '/recover1': (context) => const Recover1(),
        '/passwordresetsuccess': (context) => const PasswordResetSuccess(),
        '/test': (context) => const Test(), //TODO: Remove test route when done
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/signup1') {
          final value = settings.arguments as EditVendor; // Retrieve the value.
          return MaterialPageRoute(builder: (_) => SignUp1(value));
        }
        if (settings.name == '/signup2') {
          final value = settings.arguments as EditVendor; // Retrieve the value.
          return MaterialPageRoute(builder: (_) => SignUp2(value));
        }
        if (settings.name == '/signup3') {
          final value = settings.arguments as EditVendor; // Retrieve the value.
          return MaterialPageRoute(builder: (_) => SignUp3(value));
        }
        if (settings.name == '/signup4') {
          final value = settings.arguments as EditVendor; // Retrieve the value.
          return MaterialPageRoute(builder: (_) => SignUp4(value));
        }
        if (settings.name == '/welcome') {
          final value = settings.arguments as String; // Retrieve the value.
          return MaterialPageRoute(builder: (_) => Welcome(value));
        }
        if (settings.name == '/recover2') {
          final value =
              settings.arguments as RecoveryVerification; // Retrieve the value.
          return MaterialPageRoute(builder: (_) => Recover2(value));
        }
        if (settings.name == '/recover3') {
          final value =
              settings.arguments as RecoveryVerification; // Retrieve the value.
          return MaterialPageRoute(builder: (_) => Recover3(value));
        }

        return null;
      },
      initialRoute: '/',
    );
  }
}
