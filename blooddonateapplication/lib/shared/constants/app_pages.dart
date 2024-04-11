import 'package:blooddonateapplication/features/blood_request/presentation/getx/blood_request_bindings.dart';
import 'package:blooddonateapplication/features/blood_request/presentation/pages/blood_request_page.dart';
import 'package:blooddonateapplication/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:blooddonateapplication/features/google_sign/presentation/bindings/google_sign_in_bindings.dart';
import 'package:blooddonateapplication/features/google_sign/presentation/pages/sign_in.dart';
import 'package:blooddonateapplication/shared/presentation/splash_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.splashRoute;
  static final pages = <GetPage>[
    GetPage(name: Routes.splashRoute, page: () => SplashScreen()),
    GetPage(
        name: Routes.googleSignIn,
        page: () => GoogleSignInPage(),
        binding: GoogleSignInBindings()),
    GetPage(name: Routes.dashboard, page: () => DashboardPage()),
    GetPage(
        name: Routes.bloodrequest,
        page: () => BloodRequestPage(),
        binding: BloodRequestBindings()),
    GetPage(
        name: Routes.profileRoute,
        page: () => ProfilePage(),
        binding: ProfileBinding()),
    GetPage(
        name: Routes.editProfileRoute,
        page: () => EditProfile(),
        binding: ProfileBinding()),
  ];
}
