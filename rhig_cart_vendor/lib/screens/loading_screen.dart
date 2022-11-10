import 'package:flutter/material.dart';

Scaffold loadingScreen() {
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
            child: Text('Loading preferences...'),
          )
        ],
      ),
    ),
  );
}
