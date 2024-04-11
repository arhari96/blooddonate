import 'package:blooddonateapplication/Constants.dart';
import 'package:blooddonateapplication/features/profile/domain/entities/user_profile.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Dio(), fenix: true);

    Get.putAsync<Box<bool>>(
        () async => await Hive.openBox<bool>(HiveArguments.loggedBox),
        permanent: true);
    Get.putAsync<Box<String>>(
            () async => await Hive.openBox<String>(HiveArguments.tokenBox),
        permanent: true);
    Get.putAsync<Box<UserProfile>>(
        () async =>
            // Open the Hive box asynchronously
            await Hive.openBox<UserProfile>(HiveArguments.user_data_box),
        permanent: true);
  }
}
