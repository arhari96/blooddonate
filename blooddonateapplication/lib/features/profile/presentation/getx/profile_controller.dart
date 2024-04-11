import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../Constants.dart';
import '../../domain/entities/user_profile.dart';

class ProfileController extends GetxController{
    UserProfile? _userProfile;

    UserProfile? get userProfile => _userProfile;
    Box<UserProfile> _userProfileBox;
    ProfileController(this._userProfileBox);
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final pinCodeController = TextEditingController();
    @override
  void onInit() {

        _userProfile = _userProfileBox.get(HiveArguments.user_data);
        nameController.text = _userProfile!.name;
        emailController.text = _userProfile!.email;
    // TODO: implement onInit
    super.onInit();
  }
}