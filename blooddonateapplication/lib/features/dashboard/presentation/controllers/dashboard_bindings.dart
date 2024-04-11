import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../Constants.dart';
import '../../../profile/domain/entities/user_profile.dart';
import 'dashboard_controller.dart';

class DashBoardBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Box<UserProfile>>(() => Hive.box<UserProfile>(HiveArguments.user_data));

    Get.lazyPut<DashBoardController>(() => DashBoardController(Get.find()));
  }
}