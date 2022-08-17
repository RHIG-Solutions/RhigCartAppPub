import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/reusables/constants.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/models/vendor_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _LoginProperties _myLogin = _LoginProperties();

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
                            SafeArea(
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
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: kMarginMain, top: 30.0, right: kMarginMain),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputField(
                              node: _myLogin._emailNode,
                              nextNode: _myLogin._passwordNode,
                              controller: _myLogin._emailController,
                              label: 'Your Email',
                              hint: 'Email Address',
                              errorText: _myLogin.errorText,
                              hasIcon: true,
                              icon: Icons.mail_outline,
                            ),
                            SizedBox(height: kInputSpacer),
                            InputField(
                                node: _myLogin._passwordNode,
                                nextNode: _myLogin._passwordNode,
                                controller: _myLogin._passwordController,
                                label: 'Your Password',
                                hint: 'Password',
                                isLast: true,
                                isPassword: true),
                            Align(
                              alignment: Alignment.topRight,
                              child: buildTextButton(
                                  label: 'I forgot my password?',
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/test');
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container(height: 20.0)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: kMarginMain),
                        child: buildBottomButton(
                            label: 'SIGN IN',
                            onPressed: () {
                              setState(() {
                                if (_myLogin.loginSuccessful()) {
                                  _myLogin.errorText = '';
                                  Navigator.pushNamed(context, '/test');
                                } else {
                                  _myLogin.errorText =
                                      'Username / Password incorrect';
                                }
                              });
                            }), //TODO: Add SIGN IN button routing
                      ),
                      const SizedBox(height: 20.0),
                      Row(
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
                                Navigator.pushNamed(context, '/signup1',
                                    arguments: myVendor);
                              })
                        ],
                      )
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
}

class _LoginProperties {
  bool failed = false;
  String errorText = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  late String loggedInAccount;

  bool loginSuccessful() {
    bool _success = false;
    //TODO: Add login check with server here, replacing dummy
    if (_emailController.text == 'C' && _passwordController.text == 'C') {
      loggedInAccount = _emailController.text;
      failed = false;
      _success = true;
    } else {
      failed = true;
      _success = false;
    }
    return _success;
  }
}