import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/reusables/constants.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/models/vendor_model.dart';
import 'package:rhig_cart_vendor/models/login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Login _myLogin = Login();

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
                      //Builds Sign In Button
                      buildSignInButton(context),
                      //Builds row with Sign Up button
                      buildSignupRow(context),
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
          buildTitle(title: 'SIGN IN'),
          SizedBox(height: kTopSpacer1),
          const Text('Hi,', style: kHeader1Style),
          const Text(
            'Sign in to continue',
            style: kStandardWhiteStyle,
          ),
        ],
      ),
    );
  }

  //Builds main input section, including email, password and forgot password
  Padding buildInputSection(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: kMarginMain, top: 30.0, right: kMarginMain),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //E-Mail input field
          InputField(
            node: _myLogin.email.node,
            nextNode: _myLogin.password.node,
            controller: _myLogin.email.controller,
            label: 'Your Email',
            hint: 'Email Address',
            errorText: _myLogin.email.error,
            hasIcon: true,
            icon: Icons.mail_outline,
          ),
          SizedBox(height: kInputSpacer),
          //Password input field
          InputField(
              node: _myLogin.password.node,
              nextNode: _myLogin.password.node,
              controller: _myLogin.password.controller,
              label: 'Your Password',
              hint: 'Password',
              isLast: true,
              isPassword: true),
          //Forgot password button
          Align(
            alignment: Alignment.topRight,
            child: buildTextButton(
                label: 'I forgot my password?',
                onPressed: () {
                  Navigator.pushNamed(context, '/recover1');
                }),
          ),
        ],
      ),
    );
  }

  //Builds Sign In Button
  Padding buildSignInButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMain),
      child: buildBottomButton(
          label: 'SIGN IN',
          onPressed: () {
            setState(() {
              if (_myLogin.successful()) {
                _myLogin.password.error = '';
                Navigator.pushNamed(context, '/test');
              } else {
                _myLogin.password.error = 'Username / Password incorrect';
              }
            });
          }), //TODO: Add SIGN IN button routing
    );
  }

  //Builds row with Sign Up button
  SizedBox buildSignupRow(BuildContext context) {
    return SizedBox(
      height: kBottomButtonSpace,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account?',
            style: TextStyle(color: kRHIGDarkGreen),
          ),
          buildTextButton(
              label: 'Sign Up',
              onPressed: () {
                Vendor myVendor = Vendor();
                Navigator.pushNamed(context, '/signup1', arguments: myVendor);
              })
        ],
      ),
    );
  }
}
