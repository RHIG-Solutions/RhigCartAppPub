import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/reusables/constants.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/models/recovery_model.dart';

class Recover1 extends StatefulWidget {
  const Recover1({Key? key}) : super(key: key);

  @override
  State<Recover1> createState() => _Recover1State();
}

class _Recover1State extends State<Recover1> {
  final RecoveryVerification _myRecovery = RecoveryVerification();

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
                            topArt(),
                            buildPageDescription(),
                          ],
                        ),
                      ),
                      //Builds main input section
                      buildInputSection(context),
                      Expanded(child: Container(height: 20.0)),
                      //Builds Continue Button
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

  //Builds page description area
  SafeArea buildPageDescription() {
    return SafeArea(
      child: Column(
        children: [
          buildTitleWithPopBack(context, title: 'FORGOT PASSWORD'),
          SizedBox(height: kTopSpacer1),
          const Text('We need,', style: kHeader1Style),
          const Text(
            'your email address',
            style: kStandardWhiteStyle,
          ),
        ],
      ),
    );
  }

  //Builds main input section
  Padding buildInputSection(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: kMarginMain, top: 30.0, right: kMarginMain),
      child: InputField(
        node: _myRecovery.email.node,
        nextNode: _myRecovery.email.node,
        controller: _myRecovery.email.controller,
        label: 'Your Email',
        hint: 'Email Address',
        errorText: _myRecovery.email.error,
        isLast: true,
        hasIcon: true,
        icon: Icons.mail_outline,
      ),
    );
  }

  //Builds Continue Button
  Padding buildContinueButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMain),
      child: buildBottomButton(
          label: 'CONTINUE',
          onPressed: () {
            setState(() {
              if (_myRecovery.isValid()) {
                Navigator.pushNamed(context, '/recover2',
                    arguments: _myRecovery);
              }
            });
          }),
    );
  }
}
