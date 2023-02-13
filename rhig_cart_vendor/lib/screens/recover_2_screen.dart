import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/models/recovery_model.dart';
import 'package:rhig_cart_vendor/constants.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/models/otp_model.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';
import 'package:rhig_cart_vendor/reusables/misc_elements.dart';

class Recover2 extends StatefulWidget {
  final RecoveryVerification myRecovery;
  const Recover2(this.myRecovery, {Key? key}) : super(key: key);

  @override
  State<Recover2> createState() => _Recover2State();
}

class _Recover2State extends State<Recover2> {
  // Creates OTP instance for verification
  final OTP _myOTP = OTP();
  // Error message to display if problem with OTP
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    // Checks if theming settings loaded, and shows appropriate screen
    return ValueListenableBuilder(
      valueListenable: myPrefs.loadNotifier,
      builder: (context, value, _) {
        if (myPrefs.loadComplete == false) {
          return loadingScreen();
        } else {
          return Scaffold(
            backgroundColor: Color(myPrefs.dColourBackground),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: kTopArtHeight,
                              child: Stack(
                                children: [
                                  topArt(myPrefs: myPrefs),
                                  buildPageDescription(),
                                ],
                              ),
                            ),
                            //Builds main input section
                            buildInputSection(context),
                            Expanded(child: Container(height: 20.0)),
                            //Builds Continue Button
                            buildContinueButton(context, myPrefs: myPrefs),
                            SizedBox(
                              height: kBottomButtonSpace,
                              child: buildReturnToLoginRow(context,
                                  myPrefs: myPrefs),
                            ),
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

  //Builds page description area
  SafeArea buildPageDescription() {
    return SafeArea(
      child: Column(
        children: [
          buildTitleWithPopBack(context, title: 'VERIFY CODE'),
          SizedBox(height: kTopSpacer1),
          const Text('Verify OTP,', style: kHeader1Style),
          Text(
            'We\'ve sent an OTP to XXX XXX ${widget.myRecovery.cell.substring(6)}.',
            style: kStandardWhiteStyle,
          ),
        ],
      ),
    );
  }

  //Builds main input section
  Padding buildInputSection(BuildContext context) {
    //Space between OTP fields
    const double inputSpacer = 5;
    //Total of open space around OTP fields
    double whitespace = (kMarginMain * 2) + (inputSpacer * 3);
    //Possible width of OTP fields
    double possibleWidth =
        (MediaQuery.of(context).size.width - whitespace) / 4; //

    //Space to leave to left of fields and label on very wide screens
    double leftSpacer = 0;
    //Final width for input fields after space calculations
    double inputWidth = 0;

    //Fields will not be wider than 90 pixels.
    if (possibleWidth > 90) {
      inputWidth = 90;
      leftSpacer = (MediaQuery.of(context).size.width -
              (whitespace + (inputWidth * 4))) /
          2;
    } else {
      inputWidth = possibleWidth;
    }

    return Padding(
      padding:
          EdgeInsets.only(left: kMarginMain, top: 30.0, right: kMarginMain),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: leftSpacer),
            child: const Text('OTP', style: kLabelStyle),
          ),
          Row(
            children: [
              SizedBox(width: leftSpacer),
              OTPField(
                  node: _myOTP.number1.node,
                  nextNode: _myOTP.number2.node,
                  lastNode: _myOTP.number1.node,
                  controller: _myOTP.number1.controller,
                  width: inputWidth,
                  isLast: false),
              const SizedBox(width: inputSpacer),
              OTPField(
                  node: _myOTP.number2.node,
                  nextNode: _myOTP.number3.node,
                  lastNode: _myOTP.number1.node,
                  controller: _myOTP.number2.controller,
                  width: inputWidth,
                  isLast: false),
              const SizedBox(width: inputSpacer),
              OTPField(
                  node: _myOTP.number3.node,
                  nextNode: _myOTP.number4.node,
                  lastNode: _myOTP.number2.node,
                  controller: _myOTP.number3.controller,
                  width: inputWidth,
                  isLast: false),
              const SizedBox(width: inputSpacer),
              OTPField(
                  node: _myOTP.number4.node,
                  nextNode: _myOTP.number4.node,
                  lastNode: _myOTP.number3.node,
                  controller: _myOTP.number4.controller,
                  width: inputWidth,
                  isLast: true),
            ],
          ),
          SizedBox(height: kInputSpacer),
          Center(child: Text(errorText, style: kErrorTextStyle)),
        ],
      ),
    );
  }

  //Builds Continue Button
  Padding buildContinueButton(BuildContext context,
      {required PreferenceController myPrefs}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMain),
      child: buildBottomButton(
          label: 'CONTINUE',
          onPressed: () {
            setState(() {
              if (_myOTP.verifyOTP(email: widget.myRecovery.email.getValue())) {
                Navigator.pushNamed(context, '/recover3',
                    arguments: widget.myRecovery);
              } else {
                errorText = 'OTP Incorrect';
              }
            });
          }),
    );
  }
}
