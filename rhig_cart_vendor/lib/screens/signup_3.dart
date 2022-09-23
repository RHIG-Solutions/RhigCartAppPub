import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/reusables/constants.dart';
import 'package:rhig_cart_vendor/reusables/misc_elements.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/reusables/page_counter.dart';
import 'package:rhig_cart_vendor/models/edit_vendor_model.dart';

class SignUp3 extends StatefulWidget {
  final EditVendor myVendorEdit;
  const SignUp3(this.myVendorEdit, {Key? key}) : super(key: key);

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
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
                      SizedBox(
                        height: kBottomButtonSpace,
                        child: buildAlreadyHaveAccountRow(context),
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

  //Builds contents for page description
  SafeArea buildPageDescription(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildTitleWithBackReplacement(context,
              title: 'REGISTER',
              target: '/signup2',
              myVendor: widget.myVendorEdit),
          SizedBox(height: kTopSpacer1),
          const Text('And,', style: kHeader1Style),
          const Text(
            'Your address details?',
            style: kStandardWhiteStyle,
          ),
          SizedBox(height: kTopSpacer2),
          buildPageCounter(pageNumber: 3),
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
          //Input Street name and number
          InputField(
              node: widget.myVendorEdit.address.street.node,
              nextNode: widget.myVendorEdit.address.suburb.node,
              controller: widget.myVendorEdit.address.street.controller,
              label: 'Street',
              hint: 'Street',
              errorText: widget.myVendorEdit.address.street.error,
              hasIcon: true,
              icon: Icons.location_on_outlined),
          SizedBox(height: kInputSpacer),
          //Input Suburb - Optional field
          InputField(
              node: widget.myVendorEdit.address.suburb.node,
              nextNode: widget.myVendorEdit.address.city.node,
              controller: widget.myVendorEdit.address.suburb.controller,
              label: 'Suburb',
              hint: 'Suburb',
              errorText: widget.myVendorEdit.address.suburb.error,
              hasIcon: true,
              icon: Icons.location_on_outlined),
          SizedBox(height: kInputSpacer),
          //Input City
          InputField(
              node: widget.myVendorEdit.address.city.node,
              nextNode: widget.myVendorEdit.address.postalCode.node,
              controller: widget.myVendorEdit.address.city.controller,
              label: 'City',
              hint: 'City',
              errorText: widget.myVendorEdit.address.city.error,
              hasIcon: true,
              icon: Icons.location_on_outlined),
          SizedBox(height: kInputSpacer),
          //Input Postal Code - is a number
          InputField(
              node: widget.myVendorEdit.address.postalCode.node,
              nextNode: widget.myVendorEdit.address.postalCode.node,
              controller: widget.myVendorEdit.address.postalCode.controller,
              label: 'Postal Code',
              hint: 'Postal Code',
              errorText: widget.myVendorEdit.address.postalCode.error,
              hasIcon: true,
              icon: Icons.location_on_outlined,
              isNumber: true,
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
              if (widget.myVendorEdit
                  .isValid(street: true, city: true, postalCode: true)) {
                Navigator.pushReplacementNamed(context, '/signup4',
                    arguments: widget.myVendorEdit);
              }
            });
          }),
    );
  }
}
