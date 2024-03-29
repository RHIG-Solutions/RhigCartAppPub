import 'package:flutter/material.dart';

// Screen displayed when waiting for theme preferences to load
Widget loadingScreen() {
  return Scaffold(
    body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Loading Preferences...'),
          )
        ],
      ),
    ),
  );
}
