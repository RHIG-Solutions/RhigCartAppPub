import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/models/edit_password_model.dart';
import 'package:rhig_cart_vendor/models/recovery_model.dart';
import 'package:rhig_cart_vendor/constants.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';
import 'package:rhig_cart_vendor/screens/loading_screen.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/reusables/misc_elements.dart';

class Recover3 extends StatefulWidget {
  final RecoveryVerification myRecovery;
  const Recover3(this.myRecovery, {Key? key}) : super(key: key);

  @override
  State<Recover3> createState() => _Recover3State();
}

class _Recover3State extends State<Recover3> {
  // Create password recovery object, containing needed data and checks
  EditPassword myPasswordEdit = EditPassword();
  @override
  Widget build(BuildContext context) {
    // Gets relevant Vendor names from server
    myPasswordEdit.getNames(email: widget.myRecovery.email.getValue());
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
                                  buildPageDescription(myPasswordEdit),
                                ],
                              ),
                            ),
                            //Builds main input section
                            buildInputSection(context),
                            Expanded(child: Container(height: 20.0)),
                            //Builds Continue Button
                            buildContinueButton(context,
                                myPasswordEdit: myPasswordEdit),
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
  SafeArea buildPageDescription(EditPassword myPasswordEdit) {
    return SafeArea(
      child: Column(
        children: [
          buildTitleWithPopBack(context, title: 'RENEW PASSWORD'),
          SizedBox(height: kTopSpacer1),
          CircleAvatar(
            backgroundColor: kColourRHIGLightGrey,
            radius: kTopSpacer1 / 2,
            //TODO Implement avatar image check
            //If no image is present, Displays initials
            child: Text(
              myPasswordEdit.getInitials(),
              style: kAvatarTextStyle,
            ),
          ),
          //Display Vendor firstname
          Text('${myPasswordEdit.vendorNames.firstName}?',
              style: kHeader1Style),
          const Text(
            'Please choose your new password',
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Input Password
          InputField(
              node: myPasswordEdit.password.node,
              nextNode: myPasswordEdit.passwordCheck.node,
              controller: myPasswordEdit.password.controller,
              label: 'Password',
              hint: 'Password',
              isPassword: true,
              errorText: myPasswordEdit.password.error),
          SizedBox(height: kInputSpacer),
          //Input Repeat of password for verification
          InputField(
              node: myPasswordEdit.passwordCheck.node,
              nextNode: myPasswordEdit.passwordCheck.node,
              controller: myPasswordEdit.passwordCheck.controller,
              label: 'Repeat Password',
              hint: 'Password',
              isPassword: true,
              isLast: true,
              errorText: myPasswordEdit.passwordCheck.error),
        ],
      ),
    );
  }

  //Builds Continue Button
  Padding buildContinueButton(BuildContext context,
      {required EditPassword myPasswordEdit}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMain),
      child: buildBottomButton(
          label: 'RESET PASSWORD',
          onPressed: () {
            setState(() {
              if (myPasswordEdit.isValid()) {
                myPasswordEdit.updatePassword(
                    email: widget.myRecovery.email.getValue());
                Navigator.pushReplacementNamed(
                    context, '/passwordresetsuccess');
              }
            });
          }),
    );
  }
}
