import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/leaderboard/controller/leaderboard_controller.dart';
import 'package:flutter_application_1/color.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardView extends GetView<LeaderboardController> {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              radialGradient,
              radialGradient2,
              radialGradient3,
              radialGradient4,
            ],
            center: Alignment.center,
            radius: 1.7,
            focal: Alignment.center,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Leaderboard',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Tab Navigation
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),

                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Obx(
                      () => AnimatedAlign(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: controller.selectedIndex.value == 0
                            ? Alignment.centerLeft
                            : controller.selectedIndex.value == 1
                            ? Alignment.center
                            : Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                              color: icon,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(child: _buildTextOption('All time', 0)),
                        _buildTextOption('This Week', 1),
                        _buildTextOption('Month', 2),
                      ],
                    ),
                  ],
                ),
              ),
              Text('ajskhdg'),
              Row(
                children: [
                  SizedBox(
                    height: 400,
                    child: CircleAvatar(backgroundColor: Colors.black),
                  ),
                  SizedBox(
                    height: 400,
                    child: CircleAvatar(backgroundColor: Colors.black),
                  ),
                  SizedBox(
                    height: 400,
                    child: CircleAvatar(backgroundColor: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk tab navigation
  Widget _buildTextOption(String text, int index) {
    return GestureDetector(
      onTap: () {
        controller.changeTab(index);
      },
      child: Obx(() {
        return Text(
          text,
          style: TextStyle(
            color: controller.selectedIndex.value == index
                ? Colors.white
                : Colors.black,
            fontWeight: controller.selectedIndex.value == index
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        );
      }),
    );
  }
}
