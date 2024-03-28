import 'package:blooddonateapplication/features/google_sign/presentation/pages/sign_in.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.splashRoute;
  static final pages = <GetPage>[
    GetPage(name: Routes.googleSignIn, page: () => GoogleSignInPage()),
  ];
}
