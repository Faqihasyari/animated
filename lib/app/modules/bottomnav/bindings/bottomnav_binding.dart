import 'package:get/get.dart';
import '../controller/bottomnav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController());
  }
}
