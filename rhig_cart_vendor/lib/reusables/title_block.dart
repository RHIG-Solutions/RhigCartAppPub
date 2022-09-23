import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/models/edit_vendor_model.dart';

//Edge spaces for Icons and controls, used to center title
const double _spacer = 50;

//Title block height
const double _height = 35;

//Build standard title without controls
Widget buildTitle({required String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [const SizedBox(height: _height), _buildTitleText(title)],
  );
}

//Build title with back button that pops the screen
Widget buildTitleWithPopBack(BuildContext context, {required String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: _spacer,
        height: _height,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      _buildTitleText(title),
      const SizedBox(width: _spacer),
    ],
  );
}

//Build title with targeted back button that passes Vendor info
Widget buildTitleWithBackReplacement(BuildContext context,
    {required String title,
    required String target,
    required EditVendor myVendor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: _spacer,
        height: _height,
        child: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, target,
                arguments: myVendor);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      _buildTitleText(title),
      const SizedBox(width: _spacer),
    ],
  );
}

//Build title text widget
Text _buildTitleText(String title) {
  return Text(
    title,
    style: kHeader2Style,
  );
}
