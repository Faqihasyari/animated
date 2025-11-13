import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/bottomnav/controller/bottomnav_controller.dart';
import 'package:flutter_application_1/app/modules/leaderboard/views/leaderboard_views.dart';
import 'package:flutter_application_1/app/modules/setting/view/setting_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// import halaman lain
import 'package:flutter_application_1/app/modules/home/views/home_view.dart';

class BottomNavView extends GetView<BottomNavController> {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    // daftar halaman
    final List<Widget> pages = const [
      HomeView(),
      LeaderboardView(),
      SettingView(),
      Center(child: Text("⚙️ Pengaturan")),
    ];

    return Obx(
      () => Scaffold(
        extendBody: true,
        body: pages[controller.selectedIndex.value],

        // === Bottom Navigation Custom ===
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_outlined, "Home", 0),
                _buildNavItem(Icons.emoji_events_outlined, "Peringkat", 1),
                _buildNavItem(Icons.bookmark_border, "Bookmark", 2),
                _buildNavItem(Icons.settings_outlined, "Pengaturan", 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: isSelected ? 42 : 0,
            height: isSelected ? 42 : 0,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFF6F3C) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: isSelected ? 26 : 24,
            ),
          ),
          if (!isSelected)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(icon, color: Colors.grey, size: 24),
            ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isSelected ? Colors.black87 : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
