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
              // Podium Section - Top 3
              Container(
                height: 200,
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Posisi 2 (Kiri)
                    _buildPodiumItem(
                      rank: 2,
                      name: 'Jamal',
                      score: '91.213',
                      avatarColor: Colors.grey[400]!,
                      height: 120,
                    ),

                    // Posisi 1 (Tengah - Tertinggi)
                    _buildPodiumItem(
                      rank: 1,
                      name: 'Udin',
                      score: '95.456',
                      avatarColor: Colors.amber,
                      height: 160,
                    ),

                    // Posisi 3 (Kanan)
                    _buildPodiumItem(
                      rank: 3,
                      name: 'Budi',
                      score: '88.876',
                      avatarColor: Colors.brown[400]!,
                      height: 100,
                    ),
                  ],
                ),
              ),

              // List Peringkat 4-8
              Expanded(
                child: ListView(
                  children: [
                    _buildRankItem(4, 'Agus', '86.785'),
                    _buildRankItem(5, 'Sokid', '82.987'),
                    _buildRankItem(6, 'Joko', '80.123'),
                    _buildRankItem(7, 'Rina', '78.456'),
                    _buildRankItem(8, 'Dewi', '75.789'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk item peringkat (4-8)
  Widget _buildRankItem(int rank, String name, String score) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 65,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Center(
              child: Text(
                '$rank',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          SizedBox(width: 15),
          CircleAvatar(radius: 30, backgroundColor: Colors.black),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            score,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: icon,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk item podium (top 3)
  Widget _buildPodiumItem({
    required int rank,
    required String name,
    required String score,
    required Color avatarColor,
    required double height,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Rank Number
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
              // ternary operator
              color: rank == 1
                  ? Colors.yellow
                  : rank == 2
                  ? Colors.cyan
                  : rank == 3
                  ? Colors.grey
                  : Colors.transparent,
              width: 2,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$rank',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: 10),

        // Podium Stand
        Container(
          width: 130,
          height: height,
          decoration: BoxDecoration(
            color: icon.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: avatarColor,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                score,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
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
