import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'shared/constants/app_pages.dart';
import 'shared/constants/app_routes.dart';
import 'shared/domain/hive_adaper_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await HiveAdapterRegister().registerAdapters();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        initialBinding: MainBindings(),
        initialRoute: Routes.splashRoute,
        getPages: AppPages.pages,
        theme: ThemeData(
            useMaterial3: true,
            primaryColor: AppColors.primaryColor,
            primarySwatch: AppColors.customPrimaryColor),
      );
    });
  }
}
