// lib/app/modules/bottomnav/bindings/bottomnav_binding.dart
import 'package:get/get.dart';
import '../../home/bindings/home_binding.dart';
import '../../leaderboard/bindings/leaderboard_binding.dart';
import '../controller/bottomnav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ Include KEDUA binding agar kedua Controller tersedia
    HomeBinding().dependencies();
    LeaderboardBinding().dependencies();

    Get.lazyPut<BottomNavController>(() => BottomNavController());
  }
}
