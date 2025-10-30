import 'package:get/get.dart';
import '../../home/bottomnav/controllers/bottomnav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
  }
}
