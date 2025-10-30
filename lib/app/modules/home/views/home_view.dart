import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controller/home_controller.dart';
import 'package:flutter_application_1/color.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👤 Header user
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?img=5',
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.userName.value.isNotEmpty
                                ? 'Halo, ${controller.userName.value} 👋'
                                : 'Selamat datang di JDQuizz!',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.4),
                            ),
                            child: Text(
                              controller.userRank.value,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 100,
                        height: 41,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Icon(
                                  Icons.bolt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text('1200'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),

                  // 🔥 Daily Task Card
                  Container(
                    width: double.infinity,
                    height: 150,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tugas Harian',
                            style: GoogleFonts.poppins(color: Colors.white)),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: controller.progressValue.value,
                          color: controller.isCompleted.value
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                          backgroundColor: Colors.white24,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Progress: ${controller.answered.value} / ${controller.target.value}",
                          style:
                              GoogleFonts.poppins(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
