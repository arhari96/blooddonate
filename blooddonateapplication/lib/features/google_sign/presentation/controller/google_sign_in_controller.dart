import 'package:blooddonateapplication/features/google_sign/domain/entities/google_data.dart';
import 'package:blooddonateapplication/features/google_sign/domain/usecases/google_sign_in_usecase.dart';
import 'package:blooddonateapplication/features/profile/domain/entities/user_profile.dart';
import 'package:blooddonateapplication/shared/constants/app_pages.dart';
import 'package:blooddonateapplication/shared/constants/app_routes.dart';
import 'package:blooddonateapplication/shared/data/hive_adapters/user_profile_adapter.dart';
import 'package:blooddonateapplication/shared/data/model/data_response.dart';
import 'package:blooddonateapplication/shared/data/model/status.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../Constants.dart';

class GoogleSignInController extends GetxController {
  final GoogleSignInUseCase _googleSignInUseCase;
  GoogleSignInController(this._googleSignInUseCase);
  final Box<bool> loggedBox = Get.find();
  final Box<UserProfile> userBox = Get.find();
  Future<String> googleSignIn() async {
    try {
      DataResponse<GoogleData> apiData =
          await _googleSignInUseCase.googleSignIn();
      if (apiData.status.isSuccess) {
        userBox.put(HiveArguments.user_data, apiData.data!.userProfile);
        loggedBox.put(HiveArguments.logged, true);
        Get.offAndToNamed(Routes.dashboard);
        return apiData.message;
      } else {
        return 'Failed to Login';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
