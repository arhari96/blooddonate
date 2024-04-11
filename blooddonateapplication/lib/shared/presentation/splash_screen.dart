import 'dart:async';

import 'package:blooddonateapplication/Constants.dart';
import 'package:blooddonateapplication/shared/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/nav2/get_router_delegate.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3), () {

      final Box<bool> loggedBox = Get.find();


      bool? isLoggedIn = loggedBox.get(HiveArguments.logged, defaultValue: false);
      isLoggedIn!
          ? Get.offNamed(Routes.dashboard)
          : Get.offNamed(Routes.googleSignIn);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Blood Donate APP'),
      ),
    );
  }
}
