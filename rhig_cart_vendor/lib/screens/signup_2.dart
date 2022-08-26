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

class SignUp2 extends StatefulWidget {
  final Vendor myVendor;
  const SignUp2(this.myVendor, {Key? key}) : super(key: key);

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
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
              title: 'REGISTER', target: '/signup1', myVendor: widget.myVendor),
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
              node: widget.myVendor.cell.node,
              nextNode: widget.myVendor.email.node,
              controller: widget.myVendor.cell.controller,
              label: 'Cell Number',
              hint: '000 000 0000',
              isNumber: true,
              isCellNumber: true,
              errorText: widget.myVendor.cell.error,
              hasIcon: true,
              icon: Icons.phone),
          SizedBox(height: kInputSpacer),
          //Input Email Address
          InputField(
              node: widget.myVendor.email.node,
              nextNode: widget.myVendor.email.node,
              controller: widget.myVendor.email.controller,
              label: 'Email Address',
              hint: 'Email Address',
              errorText: widget.myVendor.email.error,
              hasIcon: true,
              icon: Icons.mail_outline,
              isLast: true),
          SizedBox(height: kInputSpacer + 10),
          //Choose to receive newsletter or not
          CheckBoxField(
              label: 'Include on newsletter and updates.',
              myVendor: widget.myVendor),
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
              if (widget.myVendor.isValid(cell: true, email: true)) {
                Navigator.pushReplacementNamed(context, '/signup3',
                    arguments: widget.myVendor);
              }
            });
          }),
    );
  }
}
