import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/reusables/constants.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/models/otp_model.dart';

class Recover2 extends StatefulWidget {
  final String cell;
  const Recover2(this.cell, {Key? key}) : super(key: key);

  @override
  State<Recover2> createState() => _Recover2State();
}

class _Recover2State extends State<Recover2> {
  final OTP _myOTP = OTP();

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
          buildTitleWithPopBack(context, title: 'VERIFY CODE'),
          SizedBox(height: kTopSpacer1),
          const Text('Verify OTP,', style: kHeader1Style),
          Text(
            'We\'ve sent an OTP to XXX XXX ' + widget.cell.substring(6) + '.',
            style: kStandardWhiteStyle,
          ),
        ],
      ),
    );
  }

  //Builds main input section
  Padding buildInputSection(BuildContext context) {
    //Space between OTP fields
    const double _inputSpacer = 5;
    //Total of open space around OTP fields
    double _whitespace = (kMarginMain * 2) + (_inputSpacer * 3);
    //Possible width of OTP fields
    double _possibleWidth =
        (MediaQuery.of(context).size.width - _whitespace) / 4; //

    //Space to leave to left of fields and label on very wide screens
    double _leftSpacer = 0;
    //Final width for input fields after space calculations
    double _inputWidth = 0;

    //Fields will not be wider than 90 pixels.
    if (_possibleWidth > 90) {
      _inputWidth = 90;
      _leftSpacer = (MediaQuery.of(context).size.width -
              (_whitespace + (_inputWidth * 4))) /
          2;
    } else {
      _inputWidth = _possibleWidth;
    }

    return Padding(
      padding:
          EdgeInsets.only(left: kMarginMain, top: 30.0, right: kMarginMain),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: _leftSpacer),
            child: const Text('OTP', style: kLabelStyle),
          ),
          Row(
            children: [
              SizedBox(width: _leftSpacer),
              OTPField(
                  node: _myOTP.number1.node,
                  nextNode: _myOTP.number2.node,
                  controller: _myOTP.number1.controller,
                  width: _inputWidth,
                  isLast: false),
              const SizedBox(width: _inputSpacer),
              OTPField(
                  node: _myOTP.number2.node,
                  nextNode: _myOTP.number3.node,
                  controller: _myOTP.number2.controller,
                  width: _inputWidth,
                  isLast: false),
              const SizedBox(width: _inputSpacer),
              OTPField(
                  node: _myOTP.number3.node,
                  nextNode: _myOTP.number4.node,
                  controller: _myOTP.number3.controller,
                  width: _inputWidth,
                  isLast: false),
              const SizedBox(width: _inputSpacer),
              OTPField(
                  node: _myOTP.number4.node,
                  nextNode: _myOTP.number4.node,
                  controller: _myOTP.number4.controller,
                  width: _inputWidth,
                  isLast: true),
            ],
          ),
        ],
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
            //TODO Implement OTP check and what must be displayed if correct
            setState(() {
              if (_myOTP.combine() == '1234') {
                Navigator.pushNamed(context, '/');
              } else {
                //TODO remove print when proper implementation is done
                print('Incorrect');
              }
            });
          }),
    );
  }
}
