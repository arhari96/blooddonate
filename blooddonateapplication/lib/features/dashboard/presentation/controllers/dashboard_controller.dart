import 'package:blooddonateapplication/Constants.dart';
import 'package:blooddonateapplication/features/profile/domain/entities/user_profile.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DashBoardController extends GetxController {
   UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;
  Box<UserProfile> _userProfileBox;
  DashBoardController(this._userProfileBox);
  @override
  void onInit() {
    _userProfile = _userProfileBox.get(HiveArguments.user_data);
    print(_userProfile);
  }
  // TODO:
}
