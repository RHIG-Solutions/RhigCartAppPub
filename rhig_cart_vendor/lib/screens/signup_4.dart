import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/models/vendor_model.dart';
import 'package:rhig_cart_vendor/reusables/constants.dart';
import 'package:rhig_cart_vendor/reusables/misc_elements.dart';
import 'package:rhig_cart_vendor/reusables/screenart.dart';
import 'package:rhig_cart_vendor/reusables/title_block.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/inputs.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';
import 'package:rhig_cart_vendor/reusables/page_counter.dart';
import 'package:rhig_cart_vendor/models/edit_vendor_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:typed_data';

enum Sources { gallery, camera }

class SignUp4 extends StatefulWidget {
  final EditVendor myVendorEdit;
  const SignUp4(this.myVendorEdit, {Key? key}) : super(key: key);

  @override
  State<SignUp4> createState() => _SignUp4State();
}

class _SignUp4State extends State<SignUp4> {
  File? _image;
  final _picker = ImagePicker();
  Vendor myVendor = Vendor();

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
              title: 'REGISTER',
              target: '/signup3',
              myVendor: widget.myVendorEdit),
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
                      widget.myVendorEdit.getInitials(),
                      style: kAvatarTextStyle,
                    ),
            ),
            onTap: () {
              _chooseImageSource();
            },
          ),
          //Display Vendor firstname
          Text('${widget.myVendorEdit.firstName.controller.text}?',
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
              node: widget.myVendorEdit.password.password.node,
              nextNode: widget.myVendorEdit.password.passwordCheck.node,
              controller: widget.myVendorEdit.password.password.controller,
              label: 'Password',
              hint: 'Password',
              isPassword: true,
              errorText: widget.myVendorEdit.password.password.error),
          SizedBox(height: kInputSpacer),
          //Input Repeat of password for verification
          InputField(
              node: widget.myVendorEdit.password.passwordCheck.node,
              nextNode: widget.myVendorEdit.password.passwordCheck.node,
              controller: widget.myVendorEdit.password.passwordCheck.controller,
              label: 'Repeat Password',
              hint: 'Password',
              isPassword: true,
              isLast: true,
              errorText: widget.myVendorEdit.password.passwordCheck.error),
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
            //TODO Implement server side checks etc
            if (widget.myVendorEdit.isValid(password: true)) {
              if (_image != null) {
                widget.myVendorEdit.encodeProfileImage(_image!);
              }
              myVendor = widget.myVendorEdit.assignValues();
              print(myVendor.profileImage);
              // if (_image != null) {
              //   Uint8List imagebytes =
              //       await _image!.readAsBytes(); //convert to bytes
              //   widget.myVendorEdit.profileImage = base64.encode(imagebytes);
              // } //convert bytes to base64 string

              setState(() {
                Navigator.pushReplacementNamed(context, '/welcome',
                    arguments: widget.myVendorEdit.email.toString());
              });
            }
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
