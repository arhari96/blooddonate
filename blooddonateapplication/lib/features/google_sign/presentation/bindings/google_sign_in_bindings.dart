import 'package:blooddonateapplication/features/google_sign/data/data_source/google_sign_in_apiservices.dart';
import 'package:blooddonateapplication/features/google_sign/data/repositories_impl/google_sign_in_repository_impl.dart';
import 'package:blooddonateapplication/features/google_sign/domain/repositories/google_sign_in_repository.dart';
import 'package:blooddonateapplication/features/google_sign/domain/usecases/google_sign_in_usecase.dart';
import 'package:blooddonateapplication/features/google_sign/presentation/controller/google_sign_in_controller.dart';
import 'package:get/get.dart';

import '../../domain/usecases/google_sign_in_usecase_impl.dart';

class GoogleSignInBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GoogleSignInApiServices>(
        () => GoogleSignInApiServices(Get.find()));
    Get.lazyPut<GoogleSignInRepository>(
        () => GoogleSignInRepositoryImpl(Get.find()));
    Get.lazyPut<GoogleSignInUseCase>(
        () => GoogleSignInUseCaseImpl(Get.find(), Get.find()));
    Get.lazyPut(() => GoogleSignInController(Get.find()), fenix: false);
  }
}
