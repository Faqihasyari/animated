import 'package:flutter_application_1/app/modules/leaderboard/controller/leaderboard_controller.dart';
import 'package:get/get.dart';

class LeaderboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaderboardController>(() => LeaderboardController());
  }
}
