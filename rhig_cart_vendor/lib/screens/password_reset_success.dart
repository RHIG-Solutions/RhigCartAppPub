import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/constants.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';

class PasswordResetSuccess extends StatelessWidget {
  const PasswordResetSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double possibleImageWidth = MediaQuery.of(context).size.width -
        kMarginMain * 2; //Possible width of image at top of page
    return Container(
      decoration: rHIGGreyBackgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100.0),
                      Image.asset(
                        'assets/images/RHIG_Solutions_icon_white.png',
                        width:
                            possibleImageWidth > 450 ? 450 : possibleImageWidth,
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width:
                            MediaQuery.of(context).size.width - kMarginMain * 2,
                        child: const Text('Password Renewed!',
                            style: kHeader1GreenStyle),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width:
                            MediaQuery.of(context).size.width - kMarginMain * 2,
                        child: const Text(
                            'Your password has successfully been renewed.',
                            textAlign: TextAlign.center,
                            style: kStandardWhiteStyle),
                      ),
                      const Text('You can now log in.',
                          style: kStandardWhiteStyle),
                      const Expanded(child: SizedBox()),
                      buildContinueButton(context),
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

  //Builds Continue button at bottom of page
  Padding buildContinueButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMain),
      child: buildBottomButton(
          label: 'GO TO STORE',
          onPressed: () {
            //TODO Fix welcome page Continue button destination etc.
            Navigator.pushReplacementNamed(context, '/');
          }),
    );
  }
}
