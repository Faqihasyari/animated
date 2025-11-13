import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/setting/controller/view_controller.dart';
import 'package:flutter_application_1/color.dart';
import 'package:get/get.dart';

class SettingView extends GetView<LogoutController> {
  SettingView({super.key});

  final LogoutController logoutController = Get.put(LogoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: btnquiz,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          onPressed: () {
            controller.logout();
          },
          child: Text("LOGOUT"),
        ),
      ),
    );
  }
}
