import 'package:get/get.dart';

import 'blood_request_controller.dart';

class BloodRequestBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => BloodRequestController());
  }
}