import 'package:blooddonateapplication/features/google_sign/presentation/controller/google_sign_in_controller.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleSignInPage extends GetView<GoogleSignInController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: ()async {
            final String result = await controller.googleSignIn();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text(result),));
          },
          child: Text('Sign In Google'),
        ),
      ),
    );
  }
}
