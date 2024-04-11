import 'package:blooddonateapplication/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:blooddonateapplication/shared/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashBoardController> {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final con = Get.put(DashBoardController(Get.find()));

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: Center(child: Text("${con.userProfile!.name}")),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.bloodtype),
          onPressed: () =>Get.toNamed(Routes.bloodrequest), label: Text('Request')),
    );
  }
}
