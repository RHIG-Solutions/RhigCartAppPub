import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/reusables/buttons.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: buildBottomButton(
        label: 'Testing Target',
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/welcome',
              arguments: 'test');
        },
      ),
    );
  }
}
