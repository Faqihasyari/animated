import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // index navigasi aktif
  var selectedIndex = 0.obs;

  // fungsi ubah tab
  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
