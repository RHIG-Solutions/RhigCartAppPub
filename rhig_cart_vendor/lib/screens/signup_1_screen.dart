import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/constants.dart';
import 'package:rhig_cart_vendor/reusables/misc_elements.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/theme_controller.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/reusables/page_counter.dart';
import 'package:rhig_cart_vendor/models/edit_vendor_model.dart';

class SignUp1 extends StatefulWidget {
  final EditVendor myVendorEdit;
  const SignUp1(this.myVendorEdit, {Key? key}) : super(key: key);

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
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
                                  //Display top arc
                                  topArt(myPrefs: myPrefs),
                                  //Display page description and information
                                  buildPageDescription(context),
                                ],
                              ),
                            ),
                            buildPageInputSection(),
                            Expanded(child: Container(height: 20.0)),
                            buildContinueButton(context, myPrefs: myPrefs),
                            SizedBox(
                              height: kBottomButtonSpace,
                              child: buildAlreadyHaveAccountRow(context,
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

  //Builds contents for page description
  SafeArea buildPageDescription(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildTitleWithPopBack(context, title: 'REGISTER'),
          SizedBox(height: kTopSpacer1),
          const Text('Tell me,', style: kHeader1Style),
          const Text(
            'What is your name?',
            style: kStandardWhiteStyle,
          ),
          SizedBox(height: kTopSpacer2),
          buildPageCounter(pageNumber: 1),
        ],
      ),
    );
  }

  //Builds input area with input fields
  Padding buildPageInputSection() {
    return Padding(
      padding:
          EdgeInsets.only(left: kMarginMain, top: 30.0, right: kMarginMain),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Input First Name
          InputField(
              node: widget.myVendorEdit.firstName.node,
              nextNode: widget.myVendorEdit.lastName.node,
              controller: widget.myVendorEdit.firstName.controller,
              label: 'First Name',
              hint: 'First Name',
              errorText: widget.myVendorEdit.firstName.error,
              hasIcon: true,
              icon: Icons.perm_identity),
          SizedBox(height: kInputSpacer),
          //Input Last Name
          InputField(
              node: widget.myVendorEdit.lastName.node,
              nextNode: widget.myVendorEdit.lastName.node,
              controller: widget.myVendorEdit.lastName.controller,
              label: 'Last Name',
              hint: 'Last Name',
              errorText: widget.myVendorEdit.lastName.error,
              hasIcon: true,
              icon: Icons.perm_identity,
              isLast: true),
        ],
      ),
    );
  }

  //Builds Continue button at bottom of page
  Padding buildContinueButton(BuildContext context,
      {required PreferenceController myPrefs}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMain),
      child: buildBottomButton(
          label: 'CONTINUE',
          onPressed: () {
            setState(() {
              //Checks to see if all required fields contain data
              if (widget.myVendorEdit
                  .isValid(firstName: true, lastName: true)) {
                Navigator.pushReplacementNamed(context, '/signup2',
                    arguments: widget.myVendorEdit);
              }
            });
          }),
    );
  }
}
