import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

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
      child: Column(
        children: [
          Text(
            'Leaderboard',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
