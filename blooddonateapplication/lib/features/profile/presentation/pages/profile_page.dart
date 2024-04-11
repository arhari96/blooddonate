import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../shared/presentation/widgets/custom_form_field.dart';
import '../getx/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.edit))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 3.h,),
          Center(
            child: CircleAvatar(
              radius: 35.sp,
              backgroundImage: NetworkImage(
                controller.userProfile!
                    .profilePic, // Replace with user's profile picture URL

              ),
            ),
          ),
        CustomFormField(title: 'Name', controller: controller.nameController, lable: 'Hari'),
          CustomFormField(title: 'Email', controller: controller.emailController, lable: 'sample email',enabled: true,),

        ],
      ));}}