import 'package:blooddonateapplication/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:blooddonateapplication/shared/constants/app_colors.dart';
import 'package:blooddonateapplication/shared/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardPage extends GetView<DashBoardController> {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final con = Get.put(DashBoardController(Get.find()));

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            decoration:  BoxDecoration(
                color: AppColors.secondaryColor),

            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    controller.userProfile!
                        .profilePic, // Replace with user's profile picture URL
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  controller.userProfile!.name, // Replace with user's name
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Drawer sections
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              // Navigate to profile screen
              Navigator.pop(context); // Close the drawer
              Get.toNamed( Routes.profileRoute);
            },
          ),
          ListTile(
            title: const Text('History'),
            onTap: () {
              // Navigate to history screen
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/history');
            },
          ),
          // Add more list tiles for additional sections...
        ],
      )),
      body: Center(child: Text("${controller.userProfile!.name}")),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.bloodtype),
          onPressed: () => Get.toNamed(Routes.bloodrequest),
          label: const Text('Request')),
    );
  }
}
