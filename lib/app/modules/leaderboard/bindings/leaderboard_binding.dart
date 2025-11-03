// lib/app/modules/leaderboard/bindings/leaderboard_binding.dart
import 'package:get/get.dart';
import '../controller/leaderboard_controller.dart';

class LeaderboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaderboardController>(() => LeaderboardController());
  }
}