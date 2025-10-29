import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

int selectedIndex = 0;

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            radialGradient, // warna atas
            radialGradient2, // warna bawah
            radialGradient3,
            radialGradient4,
          ],
          center: Alignment.center, // posisi pusat gradient
          radius: 1.7, // semakin besar nilainya, semakin luas gradient-nya
          focal: Alignment.center, // titik fokus (opsional)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          children: [
            Text(
              'Leaderboard',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  // Container biru bergerak
                  AnimatedAlign(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    alignment: selectedIndex == 0
                        ? Alignment.centerLeft
                        : selectedIndex == 1
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
          ],
        ),
      ),
    );
  }

  Widget _buildTextOption(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: selectedIndex == index ? Colors.white : Colors.black,
          fontWeight: selectedIndex == index
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
    );
  }
}
