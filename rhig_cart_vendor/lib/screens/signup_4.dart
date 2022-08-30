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
import 'dart:io';
import 'package:image_picker/image_picker.dart';

enum Sources { gallery, camera }

class SignUp4 extends StatefulWidget {
  final Vendor myVendor;
  const SignUp4(this.myVendor, {Key? key}) : super(key: key);

  @override
  State<SignUp4> createState() => _SignUp4State();
}

class _SignUp4State extends State<SignUp4> {
  File? _image;
  final _picker = ImagePicker();

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
                      buildContinueButton(),
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
              title: 'REGISTER', target: '/signup3', myVendor: widget.myVendor),
          //TODO Implement avatar image conversion, add to model and implement upload
          GestureDetector(
            child: CircleAvatar(
              //If image has been chosen, displays it
              backgroundImage: _image != null ? FileImage(_image!) : null,
              backgroundColor: kRHIGLightGrey,
              radius: kTopSpacer1 / 2,
              //If no image is chosen, Displays initials
              child: _image != null
                  ? null
                  : Text(
                      widget.myVendor.getInitials(),
                      style: kAvatarTextStyle,
                    ),
            ),
            onTap: () {
              _chooseImageSource();
            },
          ),
          //Display Vendor firstname
          Text('${widget.myVendor.firstName.controller.text}?',
              style: kHeader1Style),
          const Text(
            'Please choose your password',
            style: kStandardWhiteStyle,
          ),
          SizedBox(height: kTopSpacer2),
          buildPageCounter(pageNumber: 4),
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
          //Input Password
          InputField(
              node: widget.myVendor.password.node,
              nextNode: widget.myVendor.passwordCheck.node,
              controller: widget.myVendor.password.controller,
              label: 'Password',
              hint: 'Password',
              isPassword: true,
              errorText: widget.myVendor.password.error),
          SizedBox(height: kInputSpacer),
          //Input Repeat of password for verification
          InputField(
              node: widget.myVendor.passwordCheck.node,
              nextNode: widget.myVendor.passwordCheck.node,
              controller: widget.myVendor.passwordCheck.controller,
              label: 'Repeat Password',
              hint: 'Password',
              isPassword: true,
              isLast: true,
              errorText: widget.myVendor.passwordCheck.error),
        ],
      ),
    );
  }

  //Builds Continue button at bottom of page
  Padding buildContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kMarginMain),
      child: buildBottomButton(
          label: 'CONTINUE',
          onPressed: () {
            setState(() {
              if (widget.myVendor.isValid(password: true)) {
                //TODO Implement server side checks etc
                Navigator.pushReplacementNamed(context, '/welcome',
                    arguments: widget.myVendor.email.toString());
              }
            });
          }),
    );
  }

  //Popup dialog to choose the image source
  Future<void> _chooseImageSource() async {
    switch (await showDialog<Sources>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select image source'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Sources.gallery);
                },
                child: const Text('Image Gallery'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Sources.camera);
                },
                child: const Text('Camera'),
              ),
            ],
          );
        })) {
      case Sources.gallery:
        // Picks image from gallery
        _pickImageFromGallery();
        break;
      case Sources.camera:
        // Picks image from camera
        _pickImageFromCamera();
        break;
      case null:
        // dialog dismissed
        break;
    }
  }

  // Pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // Get image from camera
  Future<void> _pickImageFromCamera() async {
    final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 100, maxWidth: 100);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
}
