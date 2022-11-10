import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/theme_controller.dart';
import 'package:rhig_cart_vendor/constants.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';

class PasswordResetSuccess extends StatelessWidget {
  const PasswordResetSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double possibleImageWidth = MediaQuery.of(context).size.width -
        kMarginMain * 2; //Possible width of image at top of page
    return ValueListenableBuilder(
      valueListenable: myPrefs.loadNotifier,
      builder: (context, value, _) {
        if (myPrefs.loadComplete == false) {
          return loadingScreen();
        } else {
          return Container(
            decoration: rHIGGreyBackgroundDecoration,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50.0),
                            Image.asset(
                              'assets/images/RHIG_Solutions_icon_white.png',
                              width: possibleImageWidth > 450
                                  ? 450
                                  : possibleImageWidth,
                            ),
                            const SizedBox(height: 30.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  kMarginMain * 2,
                              child: Text('Password Renewed!',
                                  style: myPrefs.dHeader1Main1Style),
                            ),
                            const SizedBox(height: 20.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  kMarginMain * 2,
                              child: const Text(
                                  'Your password has successfully been renewed.',
                                  textAlign: TextAlign.center,
                                  style: kStandardWhiteStyle),
                            ),
                            const Text('You can now log in.',
                                style: kStandardWhiteStyle),
                            const Expanded(child: SizedBox()),
                            buildContinueButton(context, myPrefs: myPrefs),
                            SizedBox(height: kBottomButtonSpace),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  //Builds Continue button at bottom of page
  Padding buildContinueButton(BuildContext context,
      {required PreferenceController myPrefs}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMain),
      child: buildBottomButton(
          myPrefs: myPrefs,
          label: 'GO TO STORE',
          onPressed: () {
            //TODO Fix welcome page Continue button destination etc.
            Navigator.pushReplacementNamed(context, '/');
          }),
    );
  }
}
