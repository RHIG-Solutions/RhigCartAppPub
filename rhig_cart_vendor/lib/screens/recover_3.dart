import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/models/edit_password_model.dart';
import 'package:rhig_cart_vendor/models/recovery_model.dart';
import 'package:rhig_cart_vendor/models/vendor_model.dart';
import 'package:rhig_cart_vendor/reusables/constants.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';

class Recover3 extends StatefulWidget {
  final RecoveryVerification myRecovery;
  const Recover3(this.myRecovery, {Key? key}) : super(key: key);

  @override
  State<Recover3> createState() => _Recover3State();
}

class _Recover3State extends State<Recover3> {
  EditPassword myPasswordEdit = EditPassword();

  @override
  Widget build(BuildContext context) {
    //Create vendor using verified email address
    Vendor myVendor = Vendor(user: widget.myRecovery.email.getValue());
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
                            buildPageDescription(myVendor),
                          ],
                        ),
                      ),
                      //Builds main input section
                      buildInputSection(context),
                      Expanded(child: Container(height: 20.0)),
                      //Builds Continue Button
                      buildContinueButton(context, myVendor),
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
  SafeArea buildPageDescription(Vendor myVendor) {
    return SafeArea(
      child: Column(
        children: [
          buildTitleWithPopBack(context, title: 'RENEW PASSWORD'),
          SizedBox(height: kTopSpacer1),
          CircleAvatar(
            //TODO Implement avatar image check
            //If no image is present, Displays initials
            child: Text(
              myVendor.getInitials(),
              style: kAvatarTextStyle,
            ),
          ),
          //Display Vendor firstname
          Text('${myVendor.firstName}?', style: kHeader1Style),
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
  Padding buildContinueButton(BuildContext context, Vendor myVendor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMain),
      child: buildBottomButton(
          label: 'RESET PASSWORD',
          onPressed: () {
            setState(() {
              if (myPasswordEdit.isValid()) {
                myVendor.password = myPasswordEdit.getValue();
                //TODO Implement server side checks etc
                Navigator.pushReplacementNamed(
                    context, '/passwordresetsuccess');
              }
            });
          }),
    );
  }
}
