import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/reusables/constants.dart';
import 'package:rhig_cart_vendor/reusables/misc_elements.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/reusables/page_counter.dart';
import 'package:rhig_cart_vendor/models/vendor_model.dart';

class SignUp1 extends StatefulWidget {
  final Vendor myVendor;
  const SignUp1(this.myVendor, {Key? key}) : super(key: key);

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
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
                            topArt(),
                            //Display page description and information
                            buildPageDescription(context),
                          ],
                        ),
                      ),
                      buildPageInputSection(),
                      Expanded(child: Container(height: 20.0)),
                      buildContinueButton(context),
                      const SizedBox(height: 20.0),
                      buildAlreadyHaveAccountRow(context),
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
              node: widget.myVendor.firstName.node,
              nextNode: widget.myVendor.lastName.node,
              controller: widget.myVendor.firstName.controller,
              label: 'First Name',
              hint: 'First Name',
              errorText: widget.myVendor.firstName.error,
              hasIcon: true,
              icon: Icons.perm_identity),
          SizedBox(height: kInputSpacer),
          //Input Last Name
          InputField(
              node: widget.myVendor.lastName.node,
              nextNode: widget.myVendor.lastName.node,
              controller: widget.myVendor.lastName.controller,
              label: 'Last Name',
              hint: 'Last Name',
              errorText: widget.myVendor.lastName.error,
              hasIcon: true,
              icon: Icons.perm_identity,
              isLast: true),
        ],
      ),
    );
  }

  //Builds Continue button at bottom of page
  Padding buildContinueButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMain),
      child: buildBottomButton(
          label: 'CONTINUE',
          onPressed: () {
            setState(() {
              if (widget.myVendor.isValid(firstName: true, lastName: true)) {
                Navigator.pushReplacementNamed(context, '/signup2',
                    arguments: widget.myVendor);
              }
            });
          }),
    );
  }
}
