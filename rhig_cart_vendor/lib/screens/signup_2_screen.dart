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

class SignUp2 extends StatefulWidget {
  final EditVendor myVendorEdit;
  const SignUp2(this.myVendorEdit, {Key? key}) : super(key: key);

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
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
          buildTitleWithBackReplacement(context,
              title: 'REGISTER',
              target: '/signup1',
              myVendor: widget.myVendorEdit),
          SizedBox(height: kTopSpacer1),
          const Text('And,', style: kHeader1Style),
          const Text(
            'Your contact details?',
            style: kStandardWhiteStyle,
          ),
          SizedBox(height: kTopSpacer2),
          buildPageCounter(pageNumber: 2),
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
          //Input Cell Number - Is a number
          InputField(
              node: widget.myVendorEdit.cell.node,
              nextNode: widget.myVendorEdit.email.node,
              controller: widget.myVendorEdit.cell.controller,
              label: 'Cell Number',
              hint: '000 000 0000',
              isNumber: true,
              isCellNumber: true,
              errorText: widget.myVendorEdit.cell.error,
              hasIcon: true,
              icon: Icons.phone),
          SizedBox(height: kInputSpacer),
          //Input Email Address
          InputField(
              node: widget.myVendorEdit.email.node,
              nextNode: widget.myVendorEdit.email.node,
              controller: widget.myVendorEdit.email.controller,
              label: 'Email Address',
              hint: 'Email Address',
              errorText: widget.myVendorEdit.email.error,
              hasIcon: true,
              icon: Icons.mail_outline,
              isLast: true),
          SizedBox(height: kInputSpacer + 10),
          //Choose to receive newsletter or not
          CheckBoxField(
              myPrefs: myPrefs,
              label: 'Include on newsletter and updates.',
              myVendor: widget.myVendorEdit),
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
              if (widget.myVendorEdit.isValid(cell: true, email: true)) {
                Navigator.pushReplacementNamed(context, '/signup3',
                    arguments: widget.myVendorEdit);
              }
            });
          }),
    );
  }
}
