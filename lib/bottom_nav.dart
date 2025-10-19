import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  // Daftar halaman (Home + dummy lainnya)
  final List<Widget> _pages = const [
    MyHomePage(),
    Center(child: Text("🏆 Peringkat")),
    Center(child: Text("🔖 Bookmark")),
    Center(child: Text("⚙️ Pengaturan")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      // === Bottom Navigation Custom ===
      bottomNavigationBar: Container(
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
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
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
              child: Icon(
                icon,
                color: Colors.grey,
                size: 24,
              ),
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
