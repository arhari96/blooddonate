import 'package:blooddonateapplication/features/profile/presentation/getx/profile_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class EditProfile extends GetView<ProfileController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Column(
        children: [
          // Add text fields and other widgets for editing profile details
        ],
      ),
    );}
}