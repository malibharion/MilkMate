import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Index 0 = Dashboard (initial)
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
